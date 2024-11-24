# About this project
This project involves setting up a small infrastructure using Docker Compose, adhering to specific rules and configurations. 
The infrastructure includes services for **NGINX**, **WordPress (with PHP-FPM)**, and **MariaDB**, each running in dedicated Docker containers. 
The entire setup is configured to follow best practices for performance, security, and containerization.

### General Rules
1. The infrastructure must be implemented within a **virtual machine** using **Docker Compose**.
2. Each Docker container must:
   - Be built from either the **penultimate stable version** of **Alpine** or **Debian**.
   - Have a custom `Dockerfile` for its respective service.
3. **Pre-built Docker images** (except for Alpine/Debian base images) or services from platforms like DockerHub are **forbidden**.
4. **Makefile** is required to automate the building of Docker images and starting containers.

---

### Service Configuration

1. **NGINX Container**:
   - Configured with **TLSv1.2** or **TLSv1.3**.
   - Acts as the only entry point to the infrastructure via port **443**.
   - Ensures secure access to the infrastructure.

2. **WordPress Container**:
   - Installed and configured with **PHP-FPM** (no built-in NGINX).
   - Must connect to the MariaDB container for database operations.

3. **MariaDB Container**:
   - Runs solely as the database backend for WordPress.
   - Stores data in a persistent volume.

4. **Volumes**:
   - A volume for **WordPress database** storage.
   - Another volume for **WordPress website files**.

5. **Docker Network**:
   - A dedicated `docker-network` for inter-container communication.
   - **`network: host`**, `--link`, and `links:` directives are **prohibited**.

6. **Crash Recovery**:
   - Containers must automatically restart in case of a crash.

---

### Additional Guidelines

- Avoid using any **hacky patches** (e.g., `tail -f`, `bash`, `sleep infinity`, `while true`) to keep containers running.
- Follow best practices for managing **PID 1** and daemon processes in Docker containers.
- Create **two users** in the WordPress database:
  - One administrator user (**admin/Admin** or similar names are forbidden).
- Use **environment variables** to configure sensitive data such as passwords. These should be stored in a `.env` file located at the root of the `srcs` directory.

---

## Domain Name Configuration

- Configure a domain name (e.g., `login.42.fr`) to point to the local IP address of the virtual machine.
- Replace `login` with your specific login. For example, if your login is `wil`, configure `wil.42.fr` to redirect to the VM's IP.
