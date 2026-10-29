
## Database Backup Automation

CloudNova uses a Bash script to create compressed backups of the WordPress MySQL database. The script verifies the backup archive and automatically deletes backup files older than seven days.

### Script Location

`scripts/backup.sh`

### Backup Script

The script performs the following tasks:

1. Loads database configuration from the local `.env` file.
2. Checks whether the MySQL container exists.
3. Exports the WordPress database using `mysqldump`.
4. Compresses the database dump into a `.sql.gz` file.
5. Verifies the compressed backup using `gzip -t`.
6. Removes backup files older than seven days.

### Run the Backup

Execute the following command from the project directory on the Ubuntu Server VM:

```bash
./scripts/backup.sh
```

### Verify Backup Files

List the available database backups:

```bash
ls -lh backups/
```

Check the integrity of a backup archive:

```bash
gzip -t backups/wp_db_YYYY-MM-DD_HH-MM-SS.sql.gz
```

Replace `wp_db_YYYY-MM-DD_HH-MM-SS.sql.gz` with the actual backup filename. If the command returns to the prompt without an error, the compressed archive passed the integrity check.

### Automated Schedule

The backup script is configured for a daily 02:00 cron schedule. Verify the cron entry and check the backup log to confirm that scheduled executions are successful.

### Security Considerations

- Keep `.env` private and exclude it from version control.
- Never upload real passwords, database dumps, or other sensitive files to GitHub.
- Restrict access to backup files.
- Store additional backup copies outside the virtual machine.
- Test database restoration separately to confirm that backups can be used for recovery.
