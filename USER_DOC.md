# USER_DOC — User Documentation

This document explains how to use the Inception project as an **end user or administrator**:
what services are provided, how to start and stop them, how to access the website and admin panel, and how to verify that everything is running correctly.

---

## 1. Services Provided

This project deploys a small web infrastructure composed of the following services:

### NGINX
- Acts as the **single entry point** to the infrastructure
- Handles **HTTPS (TLSv1.2 / TLSv1.3)** connections
- Forwards requests to WordPress internally

### WordPress
- Provides the website and content management system
- Runs with **PHP-FPM**
- Includes an **administration panel** for managing content and users

### MariaDB
- Stores WordPress data (users, posts, settings)
- Is not accessible directly from outside the infrastructure

---

## 2. Starting and Stopping the Project

All commands must be run from the **root of the repository**.

### Start the Project

```bash
make
```


This will:
build the containers (if needed),
start all services,
make the website available.
Stop the Project
make down
This stops all running services without deleting data.
3. Accessing the Website
Website Access
Open a browser and go to:
https://<login>.42.fr
⚠️ HTTPS is mandatory.

The site is only accessible through NGINX on port 443.
WordPress Administration Panel

To access the admin dashboard:
https://<login>.42.fr/wp-admin

Log in using the administrator credentials defined in the .env file.

Check Running Containers
```docker ps```
You should see containers for:
nginx
wordpress
mariadb