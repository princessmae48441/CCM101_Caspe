# Two-Tier Architecture

## Definition

A Two-Tier Architecture is a system design that separates an application into two layers: the Web/Application Tier and the Database Tier. These two tiers work together to provide services to users while keeping application processing and data storage separate.

## The Web/Application Tier

The Web/Application Tier is responsible for serving the user interface and handling user requests. It processes HTTP requests from users, manages application logic, and communicates with the database to retrieve or store information. In this deployment, the Nextcloud container serves as the Web/Application Tier.

## The Database Tier

The Database Tier is responsible for storing and managing persistent data. It stores user accounts, passwords, file metadata, settings, and other important information needed by the application. In this deployment, the MariaDB container serves as the Database Tier.

## Why Separate Them?

Separating the web server and database into two containers makes the system easier to manage, maintain, and scale. Each container can be updated, restarted, or replaced independently without affecting the other service. It also provides better isolation between the application and the database.
