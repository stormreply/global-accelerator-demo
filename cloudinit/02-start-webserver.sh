#!/bin/bash

echo "BEGIN -- $(basename $0)"

dnf install -y httpd
systemctl start httpd
systemctl enable httpd

aws s3 cp s3://${assets_bucket}/architecture.drawio.svg /var/www/html/architecture.drawio.svg
aws s3 cp s3://${assets_bucket}/architecture.black.svg /var/www/html/architecture.black.svg
aws s3 cp s3://${assets_bucket}/demo /var/www/html/demo

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
instance_name=$(
    curl \
    -H "X-aws-ec2-metadata-token: $token" \
    http://169.254.169.254/latest/meta-data/tags/instance/Name
)
cat << EOS >> /var/www/html/index.html
<style>
* { font-family: sans-serif; margin: 20px; }
</style>
<!-- Instance ID --><h2>$instance_id</h2>
<!-- Instance Name --><h2>$instance_name</h2>
EOS
echo "OK" > /var/www/html/health

echo "END ---- $(basename $0)"
