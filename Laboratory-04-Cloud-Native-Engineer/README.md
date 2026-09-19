# Laboratory 04 - Cloud-Native Engineer

## Mission Overview

This laboratory introduced the basic concepts and practices of a Cloud-Native Engineer using Docker. The activities focused on understanding virtual machines and containers, launching a Docker Playground, deploying an Nginx web server, and managing the container lifecycle. Through these activities, I learned how containers can make application deployment faster and more efficient.

## Objectives

- Understand the differences between Virtual Machines and Containers.
- Verify that Docker is installed and running in a cloud-based environment.
- Pull and run an official Nginx Docker image.
- Map a host port to a container port.
- Verify a running web server using an HTTP request.
- Practice managing the Docker container lifecycle.
- Document Docker commands and their purpose.
- Develop basic skills in using Docker for cloud-native application deployment.

## Docker Commands Executed

### Checkpoint 3 - Enter the Docker Playground

```bash
docker --version
```

Checks the installed Docker version.

```bash
docker info
```

Displays detailed information about the Docker environment.

```bash
docker ps
```

Lists the currently running Docker containers.

### Checkpoint 4 - Deploy Your First Container

```bash
docker pull nginx
```

Downloads the official Nginx image from Docker Hub.

```bash
docker run -d -p 8080:80 --name nginx-server nginx
```

Creates and runs an Nginx container in detached mode and maps host port 8080 to container port 80.

```bash
docker ps
```

Checks whether the Nginx container is running.

```bash
curl http://localhost:8080
```

Sends an HTTP request to the Nginx server and displays its HTML response.

### Checkpoint 5 - The Container Lifecycle

```bash
docker ps
```

Lists the currently running containers.

```bash
docker stop nginx-server
```

Stops the running Nginx container.

```bash
docker ps
```

Verifies that the Nginx container is no longer running.

```bash
docker ps -a
```

Displays all containers, including stopped containers.

```bash
docker rm nginx-server
```

Removes the stopped Nginx container completely.

```bash
docker ps -a
```

Verifies that the Nginx container has been removed.

## Skills Learned

Through this laboratory, I learned how to use basic Docker commands in a cloud-based terminal environment. I learned how to pull images from Docker Hub, create and run containers, map ports, and test a web server using `curl`. I also learned how to stop, inspect, and remove containers. These activities helped me understand the basic workflow of deploying and managing containerized applications.

## Challenges Encountered

One challenge I encountered was becoming familiar with the Docker command syntax and understanding the purpose of each option. I also had to make sure that the correct container name and port mapping were used when running the Nginx container. Another challenge was verifying the container status after stopping and removing it. By following the commands step by step and checking the terminal output, I was able to complete the activities successfully.
