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


# Install Docker using the provided shell script
resource "null_resource" "install_docker" {
  provisioner "local-exec" {
        command = "chmod 777 ${path.module}/install-docker.sh"
    }
    provisioner "local-exec" {
        command = "bash -x ${path.module}/install-docker.sh"
    }
}

# Download Jenkins 
resource "null_resource" "download_jenkins" {
    depends_on = [null_resource.install_docker]
    provisioner "local-exec" {
        command = "chmod 777 ${path.module}/install-jenkins.sh"
    }
    provisioner "local-exec" {
        command = "bash -x ${path.module}/install-jenkins.sh"
    }
}

# # deleting already running containers
# resource "null_resource" "run_jenkins" {
#     depends_on = [null_resource.download_jenkins]
    
#     provisioner "local-exec" {
#       command = "docker system prune -f"
#     }
# }

# provider jenkins {
#   server_url = "http://localhost:8080/" 
#   username   = "admin"            
#   password   = "admin"                             
# }

# # Configure Jenkins job for deployment
# resource "jenkins_job" "example" {
#   depends_on = [null_resource.download_jenkins]
#   name        = "example-pipeline"
#   template   = file("${path.module}/job.xml")
# }

