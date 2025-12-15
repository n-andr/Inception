*This project has been created as part of the 42 curriculum by nandreev.*

# Inception

## Description

**Inception** is a system administration project focused on designing and deploying a small, production-like infrastructure using **Docker** and **Docker Compose**.

The goal is to understand how modern services are isolated, connected, and managed using containers, while respecting strict constraints similar to real-world environments:

The infrastructure consists of:
- **NGINX** as the single public entry point (TLS only),
- **WordPress** running with **php-fpm** (no web server inside),
- **MariaDB** as the database backend,
- persistent **volumes** for data,
- an isolated **Docker network** for inter-service communication.

All services are built from custom Dockerfiles and orchestrated via `docker-compose`.

---

## Project Overview

**Architecture (mandatory part):**
- NGINX → WordPress (php-fpm) → MariaDB
- TLSv1.2 / TLSv1.3 only
- Docker network isolation
- Automatic container restart
- Persistent data via volumes

**Key constraints respected:**
- No `latest` tags
- No credentials inside Dockerfiles
- No `network: host`, `links`, or infinite loops
- No “fake daemons” (`tail -f`, `sleep infinity`, etc.)
- Environment variables used everywhere

---

## Instructions

### Requirements
- Linux Virtual Machine
- Docker
- Docker Compose
- Make

### Setup & Run

refer to DEV_DOC.md

## Technical Comparisons

### Virtual Machines vs Docker

| Virtual Machines | Docker |
|------------------|--------|
| Full guest OS per instance | Shared host kernel |
| Heavy resource usage | Lightweight containers |
| Slower startup | Fast startup |
| Hardware virtualization | Process-level isolation |

**Choice:** Docker  
Docker provides lightweight isolation and faster iteration while still offering clear service separation, which fits the educational and architectural goals of the project.

---

### Secrets vs Environment Variables

| Docker Secrets | Environment Variables |
|----------------|-----------------------|
| More secure | Easier to inspect |
| File-based | Process-based |
| Production-oriented | Educational and transparent |

**Choice:** Environment Variables (`.env`)  
This project uses environment variables for simplicity and clarity. Credentials are never stored in Dockerfiles, and the `.env` file is excluded from version control.

---

### Docker Network vs Host Network

| Docker Network | Host Network |
|----------------|--------------|
| Isolated by default | No isolation |
| Internal DNS via service names | Host-dependent |
| Secure inter-container communication | Security risks |

**Choice:** Docker Network  
A custom Docker network ensures controlled communication between containers and complies with subject restrictions.

---

### Docker Volumes vs Bind Mounts

| Docker Volumes | Bind Mounts |
|----------------|-------------|
| Managed by Docker | Direct host filesystem access |
| Portable | Host-dependent paths |
| Safer defaults | Easier to misconfigure |

**Choice:** Docker Volumes  
Volumes are used for database and WordPress data to guarantee persistence across container restarts while remaining portable and safe.


## Resources

- Docker documentation: https://docs.docker.com/
- Docker Compose: https://docs.docker.com/compose/
- NGINX TLS configuration: https://nginx.org/en/docs/http/configuring_https_servers.html
- WordPress & PHP-FPM: https://developer.wordpress.org/
- MariaDB documentation: https://mariadb.org/documentation/

### AI Usage Disclosure

AI tools were used **as a learning assistant**, not as an automatic code generator, specifically for:
- clarifying Docker concepts (networks, volumes, PID 1),
- validating architecture and design decisions,
- debugging configuration and runtime errors,
- improving documentation structure and clarity.

All generated suggestions were reviewed, understood, and manually adapted.

