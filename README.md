# jenkins-aws

cd /terraform

and execute

```
ssh-keygen -t rsa -b 4096 -m pem -f key && mv key.pub modules/ec2/key.pub && mv key key.pem && chmod 400 key.pem
```

then

terraform init

then

terraform apply

to login with ssh

```
ssh -i tutorial_kp.pem ubuntu@$(terraform output -raw jenkins_public_ip)
```

get admin passoword on server

```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

then

terraform destroy
