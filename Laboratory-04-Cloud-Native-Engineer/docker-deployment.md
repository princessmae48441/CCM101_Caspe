# Checkpoint 5 - The Container Lifecycle

## 1. List Running Containers

**Command:**
```bash
docker ps
```

**Explanation:**  
This command displays all currently running Docker containers.

---

## 2. Stop the Running Container

**Command:**
```bash
docker stop my-nginx
```

**Explanation:**  
This command stops the running container named `my-nginx`.

---

## 3. Verify It Is Stopped

**Command:**
```bash
docker ps -a
```

**Explanation:**  
This command shows all containers, including stopped containers, allowing verification that `my-nginx` is no longer running.

---

## 4. Remove the Container Completely

**Command:**
```bash
docker rm my-nginx
```



