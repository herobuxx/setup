#!/bin/bash

# Install Docker and Docker Compose
install_docker() {
    echo "[+] Installing Docker..."
    sudo apt-get update

    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Install GitLab Runner
install_gitlab_runner() {
    echo "[+] Installing GitLab Runner..."
    sudo curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
    sudo apt-get install -y gitlab-runner

    sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
    sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
    sudo gitlab-runner start

    sudo usermod -aG docker gitlab-runner
    sudo systemctl restart gitlab-runner
}

# Set up Docker network
setup_docker_network() {
    echo "[+] Crteating Docker Newtork..."
    # Create Docker network liliumnet
    sudo docker network create --subnet=192.168.1.0/24 liliumnet
}

# Main function
main() {
    install_docker
    install_gitlab_runner
    setup_docker_network

    echo " "
    eCHO "[DONE] Setup Finished!"
    echo " "
}

# Call the main function
main