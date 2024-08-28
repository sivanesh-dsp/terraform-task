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
    depends_on = [null_resource.sonarqube-image]
    provisioner "local-exec" {
        command = "chmod 777 ${path.module}/install-jenkins.sh"
    }
    provisioner "local-exec" {
        command = "bash -x ${path.module}/install-jenkins.sh"
    }
}
data "local_file" "jenkins_initial_admin_password" {
  filename = "/tmp/initialAdminPassword.txt"
  depends_on = [null_resource.download_jenkins]
}

# Download SonarQube
# resource "null_resource" "download_sonarqube" {
#     depends_on = [null_resource.download_jenkins]
#     provisioner "local-exec" {
#         command = "chmod 777 ${path.module}/install-sonarqube.sh"
#     }
#     provisioner "local-exec" {
#         command = "sudo bash -x ${path.module}/install-sonarqube.sh"
#     }
# }

# sonarqube docker image
resource "null_resource" "sonarqube-image" {
    depends_on = [null_resource.install_docker]
    provisioner "local-exec" {
        command = <<-EOF
        sudo docker volume create sonarqube_data
        sudo docker volume create sonarqube_logs
        sudo docker volume create sonarqube_extensions
        sudo docker run -d --name sonarqube \
            -p 9000:9000 \
            -v sonarqube_data:/opt/sonarqube/data \
            -v sonarqube_logs:/opt/sonarqube/logs \
            -v sonarqube_extensions:/opt/sonarqube/extensions \
            sonarqube:lts-community
        EOF
    }
}