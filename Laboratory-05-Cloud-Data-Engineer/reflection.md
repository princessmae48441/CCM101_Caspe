# Mission Reflection

This laboratory gave me a better understanding of why object storage is useful for handling a very large number of photos. In my understanding, storing millions of photos on a traditional block storage hard drive would be harder to organize and manage as the data continues to grow. Object storage is designed for large amounts of unstructured data and allows files to be grouped into buckets, making it more suitable for applications that store many images.

Using Docker also made the MinIO setup easier because I only needed to use a Docker command instead of manually installing and configuring the entire storage server. I was able to specify the ports, username, password, and storage directory in one command. However, during my actual laboratory activity, I encountered problems when trying to pull the MinIO image. I received an "access denied" and "unauthorized" error, so I had to check the commands and try different approaches. This experience helped me understand that deployment does not always work immediately and that troubleshooting is part of working with cloud technologies.

A bucket in cloud storage is a container where objects or files are stored. In our activity, `client-photos` was the bucket intended for storing the sample photo or file. It helped me understand how cloud storage organizes uploaded data.

For large companies, I think they prevent data loss by keeping multiple copies of their data, using replication, backups, and storage systems across different servers or locations. This means that if one physical server crashes, another copy can still be available.

My confidence in using the Linux command line is gradually improving. At the beginning, I needed to carefully follow each command. After using commands such as `docker run`, `docker pull`, and `docker ps` and troubleshooting the MinIO errors, I became more comfortable using the terminal. I learned that making mistakes and investigating errors are also important parts of learning Linux and cloud computing.
```

