#!/bin/bash
set -e

dnf install -y httpd

cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>Blue Environment</title>
</head>
<body>
    <h1>Blue Environment</h1>
    <p>Blue deployment is currently active. From Rurigi :)</p>
    <p>Environment: BLUE</p>
</body>
</html>
HTML

echo "healthy" > /var/www/html/health

systemctl enable httpd
systemctl start httpd
