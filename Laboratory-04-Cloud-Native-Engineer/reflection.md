# Mission Reflection

This laboratory gave me a better understanding of how Docker works and why containers are widely used in modern cloud environments. Comparing Docker containers to Virtual Machines, I noticed that containers are much faster to start. Installing an operating system in a Virtual Machine takes time because it requires setting up an entire OS before applications can run. With Docker, a container can be launched in just a few seconds since it uses the host operating system and only includes the necessary files and dependencies.

The port mapping option `-p 8080:80` is important because it allows communication between the host machine and the container. The Nginx web server runs on port 80 inside the container, but users access it through port 8080 on the host system. Without port mapping, the web application would not be reachable from outside the container.

When the `docker rm` command is executed, the container is deleted from the system. Any data stored only inside that container is also removed. This taught me that containers are temporary by nature and that important data should be stored using volumes or external storage if it needs to be preserved.

I believe containerization improves collaboration between developers and operations teams. Developers can create applications that run consistently across different environments, while operations teams can deploy them more efficiently. This reduces compatibility issues and supports the DevOps goal of faster and more reliable software delivery.

My GitHub portfolio is gradually growing as I complete more cloud computing and IT-related activities. Each laboratory adds new knowledge and practical experience that I can showcase. By uploading my work, documentation, and screenshots, I am building a collection of projects that demonstrates my skills in cloud technologies, Docker, and modern software development practices. This portfolio will be useful when applying for internships and future job opportunities in the IT industry.
