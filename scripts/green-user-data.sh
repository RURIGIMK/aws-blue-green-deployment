#!/bin/bash
set -e

dnf install -y httpd

cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>Green Environment</title>
</head>
<body>
    <h1>Green Environment</h1>
    <p>Green deployment is ready for production.</p>
    <p>Environment: GREEN</p>
    <p>Deployed by Rurigi.</p>
</body>
</html>
HTML

echo "healthy" > /var/www/html/health

systemctl enable httpd
systemctl start httpd
