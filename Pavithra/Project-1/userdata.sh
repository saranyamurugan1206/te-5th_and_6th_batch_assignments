#!/bin/bash

yum update -y

yum install -y httpd

systemctl enable --now httpd

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>2-TIER WEB APPLICATION INFRASTRUCTURE ON AWS</title>
</head>

<body>

<h1>Hello from Pavithra Machha web server</h1>

<p>
This web server was provisioned automatically using Terraform.
</p>

<p>
Running on AWS EC2 inside a public subnet.
</p>

</body>
</html>
EOF