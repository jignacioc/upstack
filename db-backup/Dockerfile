FROM postgres:16

RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/*
COPY backup.sh /backup.sh
RUN chmod +x /backup.sh

# Programar cron diario a las 3 AM
RUN echo "0 3 * * * /backup.sh >> /var/log/backup.log 2>&1" > /etc/cron.d/pg_backup
RUN crontab /etc/cron.d/pg_backup

VOLUME ["/backups"]
CMD ["cron", "-f"]
