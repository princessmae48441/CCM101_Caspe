
# CloudNova: WordPress on Ubuntu Server

## Project Overview

CloudNova is an enterprise cloud infrastructure project that deploys a multi-tier web application using Docker Compose on Ubuntu Server inside VirtualBox. The application uses WordPress as the Web/Application Tier and MySQL as the Database Tier.

This project demonstrates virtualization, containerization, network configuration, firewall security, persistent storage, Infrastructure as Code (IaC), and automated database backups.

## Objectives

- Set up an Ubuntu Server virtual machine using VirtualBox.
- Install Docker Engine and Docker Compose.
- Deploy WordPress and MySQL using Docker Compose.
- Configure persistent volumes to preserve application and database data.
- Secure the server using UFW firewall rules.
- Create a Bash script for MySQL database backups.
- Schedule automated backups using Cron.
- Document the system architecture and deployment process using Markdown.

## Technologies Used

- **Host Operating System:** Windows
- **Virtualization Platform:** Oracle VirtualBox
- **Guest Operating System:** Ubuntu Server
- **Containerization:** Docker
- **Container Orchestration:** Docker Compose
- **Web/Application Tier:** WordPress
- **Database Tier:** MySQL
- **Firewall:** UFW
- **Automation:** Bash Script and Cron

## System Architecture

The Windows laptop runs VirtualBox, which hosts the Ubuntu Server virtual machine. Docker Compose manages the WordPress and MySQL containers, allowing them to communicate through a Docker network.

- **Windows Host:** Runs VirtualBox and provides access to the virtual machine.
- **Ubuntu Server:** Hosts Docker, the application containers, and the firewall.
- **WordPress:** Serves the website through HTTP on port 80.
- **MySQL:** Stores WordPress data and communicates internally with WordPress on port 3306.
- **Persistent Volumes:** Preserve WordPress files and MySQL database data.
- **UFW Firewall:** Restricts incoming connections to the required ports, including SSH (22) and HTTP (80).

See the [System Architecture Diagram](https://github.com/princessmae48441/CCM101_Caspe/blob/main/Laboratory-10-Enterprise-Cloud-Architect/diagrams/architecture-diagram.md).

## Deployment Instructions

1. Create a virtual machine in VirtualBox and install Ubuntu Server.
2. Install Docker Engine and Docker Compose.
3. Navigate to the project directory.
4. Create the environment configuration file from the example:

   ```bash
   cp .env.example .env
   ```

5. Edit `.env` and configure the required database credentials:

   ```bash
   nano .env
   ```

6. Start the application using Docker Compose:

   ```bash
   docker compose up -d
   ```

7. Verify that the containers are running:

   ```bash
   docker ps
   ```

8. Find the Ubuntu Server IP address:

   ```bash
   hostname -I
   ```

9. Open a web browser on the Windows laptop and visit:

   ```text
   http://192.168.1.50
   ```

Replace `<UBUNTU-VM-IP>` with the actual IP address of the Ubuntu Server.

## Security

- UFW is configured to allow only the necessary incoming connections.
- SSH uses port 22, and HTTP uses port 80.
- MySQL port 3306 is not published directly to the host network.
- Database credentials are stored in the `.env` file.
- The actual `.env` file must not be uploaded to GitHub.
- The `.gitignore` file should exclude `.env` and sensitive backup files.

## Backup and Recovery

The `scripts/backup.sh` script creates compressed backups of the MySQL database. Cron can be configured to run the script automatically according to a schedule.

To create a manual database backup, run:

```bash
./scripts/backup.sh
```

Backup files should be stored securely. Test the database restoration process to verify that backups can be used to recover data when necessary.

## Stopping and Restarting Services

To stop the WordPress and MySQL containers without deleting their persistent volumes, run:

```bash
docker compose stop
```

To start the containers again, run:

```bash
docker compose up -d
```

Avoid deleting Docker volumes because they contain persistent application and database data.

## Conclusion

The CloudNova project demonstrates how Docker Compose can simplify the deployment and management of a multi-tier web application. It provides practical experience in virtualization, Linux server administration, containerization, network security, persistent storage, backup automation, and Infrastructure as Code (IaC).
