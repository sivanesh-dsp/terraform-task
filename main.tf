terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
    jenkins = {
      source = "overmike/jenkins"
      version = "0.6.1"
    }
  }
}


module "jenkins_setup" {
  source = "./jenkins-setup-module"
}


# resource "null_resource" "run_jenkins" {
#   depends_on = [module.jenkins_setup]

#   provisioner "local-exec" {
#     command = "sudo docker system prune -f"
#   }
# }

# provider "jenkins" {
#   server_url = "http://localhost:8080/" 
#   username   = "admin"            
#   password   = "admin"                             
# }

# resource "jenkins_job" "example" {
#   depends_on = [module.jenkins_setup]
#   name       = "example-pipeline"
#   template   = file("${path.module}/job.xml")
# }
