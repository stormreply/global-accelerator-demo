#!/bin/bash

echo "BEGIN -- $(basename $0)"

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
cat << EOS >> /var/www/html/index.html
<style>
* { font-family: sans-serif; margin: 20px; }
</style>
<!-- Instance ID --><h2>$(curl -s http://169.254.169.254/latest/meta-data/instance-id)</h2>
<!-- Region --><h2>$region</h2>
EOS
echo "OK" > /var/www/html/health

echo "END ---- $(basename $0)"
