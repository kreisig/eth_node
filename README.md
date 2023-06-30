Run a single Ethereum mainnet node in Digital Ocean with execution and consensus client on a single host (Ubuntu Linux). Set up from beginning to end is accomplished by using Terraform to provision the droplet, Ansible for droplet configuration and docker compose to stand up the two clients.

1) Modify the main.tf with your own DO API key and SSH key ID before running terraform.
2) Modify ethereum.yml to reflect whether Ansible will be running directly from the underlying host or from a remote location.
3) Modify the docker-compose.yml to appropriately reflect directory structure and include the .env file path.
