#!/bin/bash
set -e

DATE=$(date +%F_%H-%M)
BACKUP_FILE="/backups/backup_${DATE}.dump"

echo "📦 Iniciando backup a ${BACKUP_FILE}..."

PGPASSWORD=$POSTGRES_PASSWORD pg_dump -h $POSTGRES_HOST -U $POSTGRES_USER -F c -d $POSTGRES_DB > "$BACKUP_FILE"

echo "✅ Backup realizado con éxito."

# Eliminar backups antiguos
find /backups -type f -name "*.dump" -mtime +30 -exec rm {} \;
