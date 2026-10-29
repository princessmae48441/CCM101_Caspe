
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
- **Host:** Windows laptop
- **Hypervisor:** Oracle VirtualBox
- **Server:** Ubuntu Server VM (`cloudnova`)
- **VM address used in the lab:** `192.168.1.50` (may change if the network configuration changes)
- **Application:** WordPress, published on TCP port `80`
- **Database:** MySQL 8.0, reachable by WordPress over the internal Docker network only
- **Persistent storage:** Docker named volumes for database and WordPress files
- **Firewall:** UFW, default deny incoming; allow SSH (`22/tcp`) and HTTP (`80/tcp`)
- **Automation:** Bash database backup script, configured for a daily 02:00 cron schedule

> **Security:** Do not commit `.env`, real passwords, database dumps, private keys, or other secrets. The credentials in `.env.example` are placeholders only.

## Repository Contents

| File | Purpose |
|---|---|
| `README.md` | Project overview and quick start |
| `architecture-diagram.png` | High-level network and application topology |
| `docker-compose.yml` | WordPress/MySQL deployment definition |
| `automation-script.sh` | Database backup automation |
| `operational-manual.md` | Deployment, security, operations, backup, restore, and troubleshooting |
| `final-reflection.md` | Reflection on Missions 1–10 |
| `.env.example` | Safe template for required environment variables |
| `.gitignore` | Excludes secrets, backups, and temporary files |
| `scripts/backup.sh` | Copy of the backup script at the path used by the current VM cron job |
| `backups/.gitkeep` | Keeps the empty backup directory in Git |

## Prerequisites

- A supported Windows host with VirtualBox installed.
- Ubuntu Server VM with network access.
- SSH access to the VM.
- Docker Engine and Docker Compose plugin installed.
- A user account allowed to run Docker commands.
- At least several GB of free disk space for images, WordPress files, database data, and backups.

## Quick Deployment

1. Clone or download this repository on the Ubuntu VM.
2. Copy `.env.example` to `.env`.
3. Edit `.env` and set unique, strong passwords locally.
4. Restrict access to the secrets file: `chmod 600 .env`.
5. Start the stack: `docker compose up -d`.
6. Check the services: `docker compose ps`.
7. Open [http://192.168.1.50/](http://192.168.1.50/) from a browser on the same local network, replacing the IP if the VM has a different address.


## Known Lab Validation

During the lab, the MySQL container reported `healthy`, the WordPress container was running, and the Docker volumes `cloudnova-wp_db_data` and `cloudnova-wp_wp_data` existed. Windows PowerShell tests showed TCP ports 80 and 22 reachable and port 3306 not reachable from the host. A manual compressed database backup was created and passed `gzip -t`.

The cron entry was configured, but a successful scheduled run and a restore test still need to be recorded as completed only after they are actually verified.


## Conclusion

The CloudNova project demonstrates how Docker Compose can simplify the deployment and management of a multi-tier web application. It provides practical experience in virtualization, Linux server administration, containerization, network security, persistent storage, backup automation, and Infrastructure as Code (IaC).
