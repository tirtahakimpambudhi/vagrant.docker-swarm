# Docker Swarm Vagrant Setup

This project provides a Vagrant-based environment to set up a Docker Swarm cluster. It automates the process of installing Docker, initializing the Swarm manager, and joining worker nodes to the Swarm cluster.

## Project Structure

```bash
.
├── script
│   └── docker_install.sh       # Script to install Docker on Vagrant machines
├── shared
│   ├── script
│   │   ├── init_swarm.sh       # Script to initialize the Docker Swarm manager
│   │   └── join_swarm.sh       # Script to join worker nodes to the Swarm cluster
│   └── token
│       └── join_token.json     # JSON file containing the join token for worker nodes
└── Vagrantfile                 # Vagrant configuration file
```

## Prerequisites

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Docker](https://www.docker.com/)

## Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/tirtahakimpambudhi/vagrant.docker-swarm.git
   cd vagrant.docker-swarm
   ```

2. **Bring up the Vagrant Environment**

   ```bash
   vagrant up
   ```

   This command will:
   - Create virtual machines defined in `Vagrantfile`.
   - Run the `docker_install.sh` script to install Docker on each machine.
   - Initialize the Swarm manager using `init_swarm.sh`.
   - Join worker nodes to the Swarm cluster using `join_swarm.sh`.

3. **Access the Swarm Manager**

   After the setup is complete, you can SSH into the Swarm manager to manage your cluster:

   ```bash
   vagrant ssh manager
   ```

   Use Docker commands to manage the Swarm:

   ```bash
   docker node ls    # List nodes in the Swarm
   docker service ls # List services in the Swarm
   ```

## Notes

- The `join_token.json` file contains the join token required for worker nodes to join the Swarm cluster. This token is automatically generated and shared between nodes during the setup process.
- You can modify the `Vagrantfile` to adjust the number of nodes or their specifications.

## Troubleshooting

- If you encounter any issues, ensure that your Vagrant and VirtualBox installations are up to date.
- Check the output of `vagrant up` for any errors and address them as necessary.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

