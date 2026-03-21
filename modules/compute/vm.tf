resource "azurerm_linux_virtual_machine_scale_set" "app_vmss" {

  name                = "app-vmss"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard_D2s_v3"
  instances           = 2

  admin_username = "azureuser"
  admin_password = "Password123!"   # ⚠️ for testing only
  disable_password_authentication = false

  boot_diagnostics {
    storage_account_uri = null
  }

  custom_data = base64encode(<<-EOF
  #!/bin/bash
  
  # Start nginx immediately so port 80 is open
  apt-get update -y
  apt-get install -y nginx

  # Basic page while app loads
  echo "<h1>App is starting...</h1>" > /var/www/html/index.html
  systemctl start nginx
  systemctl enable nginx

  # Install dependencies
  apt-get install -y python3 python3-pip unixodbc-dev
  curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
  curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
  apt-get update -y
  ACCEPT_EULA=Y apt-get install -y msodbcsql17
  pip3 install flask pyodbc

  # Create Flask app
  mkdir -p /myapp
  cat > /myapp/app.py << 'PYEOF'
from flask import Flask
import pyodbc
import os

app = Flask(__name__)

@app.route('/')
def home():
    try:
        conn = pyodbc.connect(
            "DRIVER={ODBC Driver 17 for SQL Server};"
            f"SERVER={os.environ.get('DB_HOST')};"
            f"DATABASE={os.environ.get('DB_NAME')};"
            f"UID={os.environ.get('DB_USER')};"
            f"PWD={os.environ.get('DB_PASS')};"
            "Encrypt=yes;"
            "TrustServerCertificate=no;"
            "Connection Timeout=30;"
        )
        cursor = conn.cursor()
        cursor.execute("SELECT @@VERSION")
        row = cursor.fetchone()
        return f"""
        <h1>Hello from {os.uname().nodename}</h1>
        <p>✅ Database Connected!</p>
        <p>DB Host: {os.environ.get('DB_HOST')}</p>
        <p>DB Name: {os.environ.get('DB_NAME')}</p>
        <p>SQL Version: {row[0]}</p>
        """
    except Exception as e:
        return f"""
        <h1>Hello from {os.uname().nodename}</h1>
        <p>❌ DB Connection Failed</p>
        <p>Error: {str(e)}</p>
        """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
PYEOF

  # Set DB environment variables
  echo "DB_HOST=${var.db_host}"     >> /etc/environment
  echo "DB_NAME=${var.db_name}"     >> /etc/environment
  echo "DB_USER=${var.db_username}" >> /etc/environment
  echo "DB_PASS=${var.db_password}" >> /etc/environment

  # Configure Nginx reverse proxy
  cat > /etc/nginx/sites-available/default << 'NGINXEOF'
server {
    listen 80;
    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
NGINXEOF

  # Create systemd service for Flask
  cat > /etc/systemd/system/flaskapp.service << 'SVCEOF'
[Unit]
Description=Flask App
After=network.target

[Service]
Environment="DB_HOST=${var.db_host}"
Environment="DB_NAME=${var.db_name}"
Environment="DB_USER=${var.db_username}"
Environment="DB_PASS=${var.db_password}"
ExecStart=/usr/bin/python3 /myapp/app.py
Restart=always

[Install]
WantedBy=multi-user.target
SVCEOF

  # Start Flask and reload Nginx
  systemctl daemon-reload
  systemctl enable flaskapp
  systemctl start flaskapp
  systemctl restart nginx

EOF
)

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
      application_gateway_backend_address_pool_ids = [
      var.backend_pool_id
  ]
    }

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

}
