
# Final Reflection: Mission 1 to Mission 10

## Where We Started (Mission 1)

When we started Mission 1, our group was still learning the basics of Linux and cloud infrastructure. We were not yet fully familiar with using the terminal to manage files, execute commands, and configure a server. We began with basic commands such as `pwd`, `ls`, `cd`, and `mkdir`, which helped us understand how to navigate the Linux environment.

At first, some tasks were confusing because a small mistake in a command or configuration could affect the result. As we continued working through the missions, we gradually became more familiar with the terminal and learned to approach problems more carefully. We realized that cloud infrastructure requires not only technical knowledge but also patience, communication, and teamwork.

## The Middle Missions (Missions 2 to 9)

- **Mission 2 – Linux and File Management:** Our group learned how to navigate directories, manage files, and understand Linux permissions. These skills became useful when organizing project files and managing the Ubuntu Server environment.

- **Mission 4 – Virtualization and Networking:** We worked with VirtualBox and Ubuntu Server to understand how a virtual machine operates within a host computer. We learned that a VM needs correct network settings before other devices can access its services.

- **Mission 6 – Docker and Containerization:** We learned how Docker containers can run application components separately while allowing them to communicate with one another. This knowledge helped us prepare for deploying WordPress and MySQL using Docker Compose.

- **Mission 9 – Automation and Self-Healing:** Our group explored how scripts and scheduled tasks can reduce repetitive manual work. For CloudNova, we prepared a database backup script that creates compressed backups and removes older backup files. This helped us understand the importance of automation, although scheduled execution and restoration still need to be verified before being considered fully tested.

Throughout these missions, we learned that working as a group involves sharing ideas, checking each other's work, and helping one another understand technical problems.

## Mission 10: What We Actually Faced

Mission 10 was challenging because we needed to combine our knowledge of Linux, networking, Docker, security, and automation into one working project. One of our major problems occurred when the Ubuntu VM did not receive an IP address while using Bridged networking. We had to investigate DHCP, subnets, gateways, and netplan. We eventually identified an incorrect subnet configuration that affected network connectivity.

We also struggled with pasting long commands into the Ubuntu console. Some commands became disorganized when the terminal was waiting for a password. We learned to use SSH and enter commands in smaller blocks, which made our work easier to manage.

Another issue involved installing Docker. The repository we initially tried did not provide the expected release for our Ubuntu setup, so we used Ubuntu's `docker.io` package instead. This taught us that installation methods can differ depending on the operating system and repository configuration.

Configuring UFW was another important part of the project. We needed to allow SSH and HTTP while preventing unnecessary incoming connections. Some firewall rules did not apply correctly at first, so we had to review and fix the configuration to maintain access to the server.

We also encountered an error during our first database restoration attempt because we entered a placeholder filename instead of the actual backup filename. This reminded us to verify filenames and commands carefully, especially when handling important data.

Among these experiences, the networking problem taught our group one of the most important lessons. Instead of repeatedly trying different solutions without understanding the cause, we learned to check the configuration step by step. We realized that troubleshooting requires patience, logical thinking, and cooperation among team members.

## Technical Lessons

Our group learned that Docker volumes help preserve data even when containers are restarted or recreated. In CloudNova, we used named volumes for the MySQL database and WordPress files. However, we also learned that volumes do not protect data if the volume or the virtual machine's disk is lost.

We also understood why MySQL port 3306 should not be published to the host when direct external database access is unnecessary. WordPress can communicate with MySQL through the internal Docker network, reducing unnecessary exposure of the database service.

Another lesson was the importance of UFW's default-deny incoming policy. By allowing only the required ports, such as SSH on port 22 and HTTP on port 80, we reduced unnecessary access to our server while keeping the services needed for the project available.

Finally, we learned that backups must be scheduled and monitored. Persistent volumes help retain data, but backups provide another way to recover from accidental deletion, corruption, or other failures. We also learned that checking a compressed backup file is not enough; restoration should be tested to confirm that the data can actually be recovered.

## What We Would Do Differently

If our group could repeat the project, we would plan the network configuration more carefully before deploying the application. We would verify the IP address, subnet, gateway, and internet connectivity before proceeding to the next requirement.

We would also test each component separately before combining everything through Docker Compose. Before enabling firewall rules, we would double-check them to avoid losing remote access to the server. For automation, we would verify the cron schedule, examine the backup logs, and perform a restoration test using an actual backup file.

Most importantly, we would improve our communication and documentation throughout the project. Keeping track of commands, errors, and successful solutions would help all team members understand the process and make troubleshooting more efficient.

## Closing

Compared with Mission 1, our group now has a better understanding of how Linux, virtualization, networking, Docker, firewalls, and automation work together in a cloud environment. We experienced several challenges, but each one gave us an opportunity to understand the technology instead of simply following instructions.

CloudNova taught us that deploying an application is only one part of cloud administration. A working system must also be properly configured, secured, maintained, and prepared for recovery. Through this project, we learned the importance of teamwork, patience, communication, and careful troubleshooting.

Overall, the ten missions helped us build our confidence and develop practical skills that we can continue improving in future projects. We recognize that there is still more to learn, particularly in production security, monitoring, and disaster recovery, but this experience gave our group a stronger foundation in cloud infrastructure.
