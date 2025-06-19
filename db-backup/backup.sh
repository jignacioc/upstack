#!/bin/bash
set -e

DATE=$(date +%F_%H-%M)
BACKUP_FILE="/backups/backup_${DATE}.dump"

echo "[$(date)] Iniciando backup a ${BACKUP_FILE}..."

# Validar variables mínimas
if [[ -z "$POSTGRES_PASSWORD" || -z "$POSTGRES_HOST" || -z "$POSTGRES_USER" || -z "$POSTGRES_DB" ]]; then
    echo "❌ Variables POSTGRES_* no definidas correctamente"
    exit 1
fi

export PGPASSWORD="$POSTGRES_PASSWORD"

pg_dump -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -F c -d "$POSTGRES_DB" -f "$BACKUP_FILE"

echo "✅ Backup realizado con éxito."

# Eliminar backups antiguos
find /backups -type f -name "*.dump" -mtime +30 -exec rm {} \;
