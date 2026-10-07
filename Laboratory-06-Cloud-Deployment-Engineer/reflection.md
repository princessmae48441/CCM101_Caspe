# Mission Reflection

Writing a `docker-compose.yml` file makes a cloud engineer's job easier because all the settings needed for the application are placed in one configuration file. Instead of manually typing many commands for each container, the engineer can use `docker-compose up -d` to deploy the services together. This makes the deployment faster, organized, and easier to repeat.

If there is an indentation error in a YAML file, Docker Compose may not be able to read the configuration correctly. For example, using a Tab instead of Spaces can cause a YAML parsing error. The deployment may fail because YAML depends on proper indentation to understand the structure of the configuration. Because of this, I learned that proper spacing and indentation are important when creating YAML files.

We used environment variables such as `MYSQL_PASSWORD`, `MYSQL_DATABASE`, and `MYSQL_USER` to provide the database information needed by Nextcloud. These variables help configure the connection between the Nextcloud application and the MariaDB database. The `MYSQL_HOST=database` variable also tells Nextcloud where to find the database container.

Deploying Nextcloud in just a few minutes felt convenient and satisfying because I was able to see a working cloud storage system without manually configuring every part of it. It helped me understand how Docker Compose can make deployment faster and easier.

Since Mission 1, my understanding of Cloud Computing has improved. I started with the basic concepts of cloud computing and gradually learned about virtualization, containers, Docker, storage, and deployment. This mission helped me understand how Infrastructure as Code can be used to automate deployments. I also learned that cloud computing is not only about storing data online but also about managing applications, services, and infrastructure efficiently.
