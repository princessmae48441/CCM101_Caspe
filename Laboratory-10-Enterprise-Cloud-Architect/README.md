
# CloudNova: WordPress on Ubuntu Server

## Project Overview
CloudNova is an enterprise cloud infrastructure project that deploys a WordPress website and MySQL database using Docker Compose on Ubuntu Server inside VirtualBox.

The project demonstrates virtualization, containerization, network configuration, firewall security, persistent storage, and automated database backups.

## Objectives
- Set up Ubuntu Server inside VirtualBox.
- Install Docker and Docker Compose.
- Deploy WordPress and MySQL using Docker Compose.
- Configure persistent volumes for data storage.
- Secure the server using UFW firewall rules.
- Create a script for database backups and schedule automated backups.

## Technologies Used
- Host OS: Windows
- Virtualization: Oracle VirtualBox
- Guest OS: Ubuntu Server
- Containerization: Docker
- Orchestration: Docker Compose
- Web Application: WordPress
- Database: MySQL
- Firewall: UFW
- Automation: Bash Script and Cron

## System Architecture
The Windows laptop runs VirtualBox, which hosts the Ubuntu Server virtual machine. Docker Compose manages the WordPress and MySQL containers.

- **WordPress:** Web application, accessible through HTTP on port 80.
- **MySQL:** Database service on port 3306, used internally by WordPress.
- **Persistent Volumes:** Preserve WordPress files and database data.
- **UFW:** Restricts incoming connections to required ports, such as SSH (22) and HTTP (80).

See the [Architecture Diagram](diagrams/architecture-diagram.md).


```
## Deployment Instructions
1. Install Ubuntu Server in VirtualBox.
2. Install Docker Engine and Docker Compose.
3. Copy `.env.example` to `.env`.
4. Configure the required database credentials in `.env`.
5. Navigate to the project directory.
6. Start the services:

   ```bash
   docker compose up -d
   ```

7. Check the running containers:

   ```bash
   docker ps
   ```

8. Open a browser and visit:

   ```text
   http://<UBUNTU-VM-IP>
   ```

Replace `<UBUNTU-VM-IP>` with the current IP address of your Ubuntu Server.

## Security
- UFW is configured to allow only necessary incoming ports.
- MySQL port 3306 is not published to the host network.
- Database credentials are stored in `.env`.
- The actual `.env` file must not be uploaded to GitHub.

## Backup and Recovery
The `scripts/backup.sh` script creates compressed MySQL database backups. Cron can schedule the script to run automatically.

Run a manual backup:

```bash
./scripts/backup.sh
```

Keep backup files secure and verify that a backup can be restored before relying on it.

## Stopping the Services
To stop the WordPress and MySQL containers without deleting their persistent volumes:

```bash
docker compose stop
```

To start them again:

```bash
docker compose up -d
```

Avoid deleting Docker volumes because they contain persistent application and database data.

