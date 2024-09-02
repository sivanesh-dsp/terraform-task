## Run this sequence of terraform commands

1. `terraform init`
2. `terraform plan -target=module.jenkins_setup`
3. `terraform apply -target=module.jenkins_setup -auto-approve`

   ( Complete the manual setup of jenkins and sonarqube )

4. `terraform apply -auto-approve`
