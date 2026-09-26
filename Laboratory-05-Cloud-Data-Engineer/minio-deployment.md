# MinIO Deployment Documentation

## Technical Documentation

This document describes the technical steps taken to deploy MinIO using Docker, access the MinIO Web Console, create a bucket, and upload a sample file.

---

## 1. Docker Deployment

The MinIO server was deployed using the following Docker command:

```bash
docker run -d -p 9000:9000 -p 9001:9001 --name minio-server \
-e "MINIO_ROOT_USER=cloudadmin" \
-e "MINIO_ROOT_PASSWORD=CloudNova2026!" \
minio/minio server /data --console-address ":9001"
```

### Explanation of the Docker Command

| Command / Option | Description |
|---|---|
| `docker run` | Creates and starts a new Docker container. |
| `-d` | Runs the container in detached mode. |
| `-p 9000:9000` | Maps host port 9000 to container port 9000 for the MinIO API. |
| `-p 9001:9001` | Maps host port 9001 to container port 9001 for the MinIO Web Console. |
| `--name minio-server` | Names the Docker container `minio-server`. |
| `-e "MINIO_ROOT_USER=cloudadmin"` | Sets the MinIO root username to `cloudadmin`. |
| `-e "MINIO_ROOT_PASSWORD=CloudNova2026!"` | Sets the MinIO root password. |
| `minio/minio` | Specifies the MinIO Docker image. |
| `server /data` | Starts the MinIO server and uses `/data` as the storage directory. |
| `--console-address ":9001"` | Configures the MinIO Web Console to use port 9001. |

---

## 2. Accessing the MinIO Web Console

The MinIO Web Console was accessed using **port 9001**.

In the KillerCoda Playground, port `9001` was entered in the **Traffic / Ports** or **Custom Ports** section. The **Access** button was then clicked to open the MinIO Web Console.

### Web Console Port

```text
9001
```

Port `9000` is used for the MinIO API and object storage service, while port `9001` is used for the MinIO Web Console.

---

## 3. MinIO Login Credentials

The credentials defined in the Docker command were used to log in to the MinIO Web Console.

### Username

```text
cloudadmin
```

### Password

```text
CloudNova2026!
```

---

## 4. Creating the Bucket

After logging into the MinIO Web Console, the **Buckets** section was opened.

A new bucket was created with the following name:

```text
client-photos
```

The `client-photos` bucket was successfully created.

---

## 5. Uploading a Sample File

Inside the `client-photos` bucket, the **Upload** button was used to upload a sample file.

The uploaded file was:

```text
sample.txt
```

The file was successfully uploaded to the `client-photos` bucket.

---

## 6. Environment Variables

The `-e` flags in the Docker command are used to define **environment variables** inside the MinIO container.

### MINIO_ROOT_USER

```bash
-e "MINIO_ROOT_USER=cloudadmin"
```

This sets the username for the MinIO root administrator account.

The root username used in this deployment was:

```text
cloudadmin
```

### MINIO_ROOT_PASSWORD

```bash
-e "MINIO_ROOT_PASSWORD=CloudNova2026!"
```

This sets the password for the MinIO root administrator account.

The password is used together with the root username to log in to the MinIO Web Console.

---

## 7. Bucket and File Information

| Item | Details |
|---|---|
| Storage Platform | MinIO |
| Deployment Method | Docker |
| Container Name | `minio-server` |
| MinIO API Port | `9000` |
| Web Console Port | `9001` |
| Root Username | `cloudadmin` |
| Bucket Name | `client-photos` |
| Uploaded File | `sample.txt` |

---

## 8. Deployment Result

The MinIO server was successfully deployed using Docker.

The MinIO Web Console was accessed through port `9001`. The `client-photos` bucket was successfully created, and the `sample.txt` file was uploaded to the bucket.

This confirmed that the MinIO object storage server was running properly and that files could be stored inside a bucket through the Web Console.

---


