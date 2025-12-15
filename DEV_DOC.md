# DEV_DOC — Developer Documentation

This document explains how a developer can set up, build, run, and manage the Inception infrastructure from scratch.

---

## 1. Prerequisites

### System Requirements
- Linux Virtual Machine (required by subject)
- Docker
- Docker Compose
- Make

Verify installation:

```bash
docker --version
docker compose version
make --version
```

## 2. Repository Structure

```text
.
├── Makefile
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── nginx
        ├── wordpress
        ├── mariadb
```

## 3. Environment Configuration

The project uses a .env file located at:
srcs/.env
This file contains:
domain name
database credentials
WordPress configuration values

Example:
``` text
DOMAIN_NAME=login.42.fr

MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
MYSQL_PASSWORD=wp_password
MYSQL_ROOT_PASSWORD=root_password

WP_ADMIN_USER=wp_admin
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@example.com

WP_USER=wp_user
WP_USER_PWD=user_password
WP_USER_EMAIL=user@example.com

WORDPRESS_DB_HOST=mariadb
WORDPRESS_DB_NAME=wordpress
WORDPRESS_DB_USER=wpuser
WORDPRESS_DB_PASSWORD=password
```

⚠️ Important
The .env file must not be committed to git.
No credentials are stored in Dockerfiles.
Environment variables are injected at runtime by Docker Compose.


## 4. Build & Launch

Create .env file in /srcs folder following and example

From the repository root:
``` bash
make
```

This command:
prepares the environment,
builds all Docker images,
creates the Docker network,
creates volumes,
starts all containers.
Docker Compose is invoked internally by the Makefile.

To stop the Infrastructure, while preserving volumes.
``` bash
make down
```