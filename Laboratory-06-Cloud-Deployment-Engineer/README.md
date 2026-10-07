
---

### `README.md`

```markdown
# Mission 6 - The Cloud Deployment Engineer

## Mission Overview

This mission focused on deploying a multi-tier private cloud storage system using Docker Compose. The application used Nextcloud as the Web/Application Tier and MariaDB as the Database Tier. Docker Compose was used to deploy both containers together using a single configuration file.

## Objectives

- Understand the concept of multi-tier architecture.
- Create a `docker-compose.yml` file.
- Use YAML to configure Docker services.
- Deploy Nextcloud and MariaDB using Docker Compose.
- Access the Nextcloud web interface through port 8080.
- Understand Infrastructure as Code (IaC).
- Document the deployment process using Markdown.

## Commands Executed

```bash
mkdir nextcloud-deployment
cd nextcloud-deployment
nano docker-compose.yml
docker-compose up -d
docker-compose ps
docker-compose down
