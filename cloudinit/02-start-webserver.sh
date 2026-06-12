#!/bin/bash

echo "BEGIN -- $(basename $0)"

dnf install -y httpd
systemctl start httpd
systemctl enable httpd
token=$(
    curl \
    -X PUT \
    -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" \
    http://169.254.169.254/latest/api/token
)
instance_id=$(
    curl \
    -H "X-aws-ec2-metadata-token: $token" \
    http://169.254.169.254/latest/meta-data/instance-id
)
cat << EOS >> /var/www/html/index.html
<style>
* { font-family: sans-serif; margin: 20px; }
</style>
<!-- Instance ID --><h2>$instance_id</h2>
<!-- Region --><h2>${region}</h2>
EOS
echo "OK" > /var/www/html/health

echo "END ---- $(basename $0)"
