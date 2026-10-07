# Docker Compose Guide

## What does the `services:` block do?

The `services:` block defines the containers that are needed for the application. In this project, there are two services: `database` and `app`. The `database` service uses MariaDB, while the `app` service uses Nextcloud.

## How does the Nextcloud app container find the database?

The Nextcloud app container uses the `MYSQL_HOST` environment variable to find the database container.

In the Compose file, we have:

```yaml
- MYSQL_HOST=database
