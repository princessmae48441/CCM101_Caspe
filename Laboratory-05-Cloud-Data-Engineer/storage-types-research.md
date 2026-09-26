# Cloud Storage Types Research

## Comparison of Cloud Storage Types

| Storage Type | Description | Primary Use Case | Cloud Provider Example |
|---|---|---|---|
| **Block Storage** | Stores data in separate blocks that can be accessed and managed individually. It works like a virtual hard drive and is useful when applications need fast and direct access to data. | Best for operating systems, databases, and applications that require high-performance storage. | **AWS EBS (Elastic Block Store)** |
| **File Storage** | Stores data as files organized into folders and directories. It uses a familiar file system structure that allows multiple users or applications to access shared files. | Best for shared files, documents, and applications that need a traditional file system. | **AWS EFS (Elastic File System)** |
| **Object Storage** | Stores data as objects together with metadata and a unique identifier. Objects are organized into containers called buckets. | Best for large amounts of unstructured data such as images, videos, documents, and backups. | **AWS S3 (Simple Storage Service)** |

## Why Object Storage is the Best Choice

Object Storage is the best choice for the client's photo-sharing application because it is designed to store large amounts of unstructured data such as user-uploaded images. It organizes the images into buckets and allows them to be easily accessed and managed, making it suitable for an application that may need to store millions of photos.
