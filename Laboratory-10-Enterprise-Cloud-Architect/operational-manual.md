# Operational Manual: CloudNova WordPress + MySQL Private Cloud

Handover document for the client's IT team.
Stack: WordPress + MySQL 8.0 on Docker Compose, Ubuntu Server VM, UFW firewall, automated nightly backups.

---

## 1. System Overview

| Item | Value |
|---|---|
| Host | Windows laptop running Oracle VirtualBox |
| VM name | CloudNova-Server |
| OS | Ubuntu Server 26.10 (headless) |
| VM network | Bridged Adapter (Wi-Fi), static IP `192.168.1.50/24`, gateway `192.168.1.1` |
| Containers | `cloudnova_wordpress` (wordpress:latest), `cloudnova_mysql` (mysql:8.0) |
| Docker network | `cloudnova-wp_wp_net` (bridge) |
| Persistent volumes | `cloudnova-wp_db_data` (MySQL data), `cloudnova-wp_wp_data` (WordPress files) |
| Firewall | UFW, default deny incoming, allow 22/tcp and 80/tcp only |
| Automation | `automation-script.sh` (deployed on the VM as `scripts/backup.sh`) run by cron daily at 02:00 |
| Project folder on VM | `/home/doriagroup/cloudnova-wp` |

Architecture: see `architecture-diagram.png`.

Traffic flow: Browser (host laptop) -> VirtualBox bridged NIC -> UFW (port 80) -> Docker port mapping -> `cloudnova_wordpress` -> `wp_net` -> `cloudnova_mysql` (port 3306, internal only).

---

## 2. Prerequisites

- Laptop with VirtualBox (any Type 2 hypervisor works)
- Ubuntu Server ISO
- VM: 2 CPU, 2-4 GB RAM, 20 GB disk, Network = Bridged Adapter on the adapter the laptop actually uses (Wi-Fi or Ethernet, not the Hyper-V virtual adapter)
- During install: enable "Install OpenSSH server"; set a static IPv4 (subnet `/24`)

---

## 3. Deployment

### 3.1 Base system

```bash
ip -4 addr show enp0s3            # confirm 192.168.1.50/24
ping -c 3 8.8.8.8                 # confirm internet
sudo apt update && sudo apt upgrade -y
```

Work over SSH from the host so copy-paste works:

```powershell
ssh doriagroup@192.168.1.50
```

### 3.2 Install Docker and Compose

The Docker apt repository did not yet publish a release for Ubuntu 26.10 (codename `stonking`), so the Ubuntu packages were used:

```bash
sudo apt install -y docker.io docker-compose-v2
sudo usermod -aG docker $USER
newgrp docker
docker --version
docker compose version
docker run hello-world
```

### 3.3 Deploy the stack

```bash
mkdir -p ~/cloudnova-wp/scripts ~/cloudnova-wp/backups
cd ~/cloudnova-wp
cp .env.example .env              # then edit passwords (nano .env)
chmod 600 .env
# place docker-compose.yml here
docker compose config             # validate
docker compose up -d
docker compose ps
docker volume ls
```

Expected: `cloudnova_mysql` Up (healthy), `cloudnova_wordpress` Up, and the two volumes listed.

Open `http://192.168.1.50` from the host browser and complete the WordPress installer.

### 3.4 Why the design looks like this

- `depends_on` with `service_healthy`: WordPress starts only after MySQL passes its healthcheck.
- Named volumes: data lives outside the container lifecycle, so `docker compose down` or a VM reboot does not delete it.
- `restart: unless-stopped`: containers come back automatically after a reboot.
- No `ports:` on MySQL: the database is not reachable from the LAN.
- Secrets in `.env` (not committed); `.env.example` documents the keys.

---

## 4. Security Hardening

### 4.1 UFW

Add the allow rules before enabling, otherwise the SSH session is cut:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp comment 'SSH'
sudo ufw allow 80/tcp comment 'WordPress HTTP'
sudo ufw enable
sudo ufw status verbose
```

Expected result:

```
Status: active
Default: deny (incoming), allow (outgoing), deny (routed)

22/tcp   ALLOW IN  Anywhere   # SSH
80/tcp   ALLOW IN  Anywhere   # WordPress HTTP
```

### 4.2 Verification from the host (PowerShell)

```powershell
Test-NetConnection 192.168.1.50 -Port 3306   # TcpTestSucceeded : False
Test-NetConnection 192.168.1.50 -Port 80     # True
Test-NetConnection 192.168.1.50 -Port 22     # True
```

Result recorded during testing: 3306 failed (blocked), 80 and 22 succeeded.

### 4.3 Notes

- Docker publishes ports through its own iptables rules, which can bypass UFW. That is why only port 80 is published and MySQL has no published port.
- Optional hardening: `PermitRootLogin no` in `/etc/ssh/sshd_config`, then `sudo systemctl restart ssh`.
- Use strong, unique values in `.env`. Never commit `.env`.

---

## 5. Automation: Backup and Disaster Recovery

### 5.1 Script

`automation-script.sh` dumps the `wordpress` database with `mysqldump --single-transaction`, compresses it to `backups/wp_db_<timestamp>.sql.gz`, and deletes files older than 7 days.

Install and test on the VM:

```bash
cp automation-script.sh ~/cloudnova-wp/scripts/backup.sh
chmod +x ~/cloudnova-wp/scripts/backup.sh
~/cloudnova-wp/scripts/backup.sh
ls -lh ~/cloudnova-wp/backups
gzip -t ~/cloudnova-wp/backups/wp_db_*.sql.gz && echo "archive OK"
```

The `mysqldump: [Warning] Using a password on the command line` message is expected.

### 5.2 Cron

```bash
crontab -e
```

```
0 2 * * * /home/doriagroup/cloudnova-wp/scripts/backup.sh >> /home/doriagroup/cloudnova-wp/backups/backup.log 2>&1
```

Check with `crontab -l` and `systemctl status cron`.

Timezone note: Ubuntu defaults to UTC, so 02:00 is 10:00 in the Philippines. To run at 02:00 local time:

```bash
sudo timedatectl set-timezone Asia/Manila
```

To demonstrate cron quickly, temporarily use `* * * * *`, wait one minute, confirm a new file appears in `backups/` and lines in `backup.log`, then restore `0 2 * * *`.

### 5.3 Restore procedure

Always use the real file name (not a placeholder):

```bash
cd ~/cloudnova-wp
source .env
ls backups/
gunzip < backups/wp_db_2026-10-29_02-13-10.sql.gz \
  | docker exec -i cloudnova_mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" wordpress
```

Then reload the site and confirm posts and pages are intact.

Note: this backs up the database. WordPress uploads and themes live in the `cloudnova-wp_wp_data` volume; back it up separately if media matters:

```bash
docker run --rm -v cloudnova-wp_wp_data:/data -v ~/cloudnova-wp/backups:/backup ubuntu \
  tar czf /backup/wp_files_$(date +%F).tar.gz -C /data .
```

---

## 6. Persistence Test

1. Publish a test post or page in WordPress.
2. `sudo reboot`
3. SSH back in: `cd ~/cloudnova-wp && docker compose ps` (both containers Up automatically).
4. Reload `http://192.168.1.50`; the content is still there.
5. Extra: `docker compose down` then `docker compose up -d` (no `-v`); data remains.

Warning: `docker compose down -v` deletes the volumes and all data.

---

## 7. Routine Maintenance

| Task | Command |
|---|---|
| Container status | `docker compose ps` |
| Logs | `docker compose logs --tail 50` |
| Update images | `docker compose pull && docker compose up -d` |
| OS updates | `sudo apt update && sudo apt upgrade -y` |
| Firewall status | `sudo ufw status verbose` |
| Backup check | `ls -lh ~/cloudnova-wp/backups` and `tail ~/cloudnova-wp/backups/backup.log` |
| Disk usage | `df -h` and `docker system df` |
| Clean unused images | `docker image prune` |

Take a backup before every image update.

---

## 8. Troubleshooting (issues actually encountered)

| Symptom | Cause | Fix |
|---|---|---|
| VM has no IPv4 address on Bridged | DHCP not answered on Wi-Fi | Set a static IP (netplan) matching the host network |
| `ip addr` shows both `/26` and `/24` | `00-installer-config.yaml` (written at install with `/26`) overlaps `50-cloud-init.yaml` | Keep one correct file; `sudo mv /etc/netplan/00-installer-config.yaml /root/` then `sudo netplan apply` |
| Cloud-init rewrites netplan on boot | cloud-init manages network | `echo 'network: {config: disabled}' \| sudo tee /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg` |
| `apt` fails: `Temporary failure resolving` | No route/DNS yet | Fix netplan, verify `ping 8.8.8.8` and `ping google.com`, retry with `-o Acquire::Retries=10` |
| Docker repo returns 404 for Ubuntu 26.10 | No Docker release for the new codename | Use `docker.io` and `docker-compose-v2` from Ubuntu |
| Pasted multi-line commands get mixed up | Paste while `sudo` waits for the password | Run `sudo -v` first, paste one block at a time, use SSH instead of the VM console |
| Restore says `No such file` | Placeholder `XXXX` used in the command | `ls backups/` and use the real file name |
| `Test-NetConnection: command not found` | PowerShell command typed in Ubuntu | Run it in Windows PowerShell on the host |
| SSH drops after enabling UFW | Allow rule for 22 was missing | Add `sudo ufw allow 22/tcp` from the VM console |
| Backup log file missing | Cron has not run yet | Wait for the scheduled time or use the every-minute test |

---

## 9. Quick Command Reference

```bash
# Start / stop
docker compose up -d
docker compose down

# Inspect
docker compose ps
docker compose logs -f wordpress
docker exec -it cloudnova_mysql mysql -uroot -p

# Security
sudo ufw status verbose

# Backup / restore
~/cloudnova-wp/scripts/backup.sh
crontab -l
```

