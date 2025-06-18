#!/bin/bash

# ⚙️ Configuration
CONTAINER_MYSQL="mysql_db"
DB_USER="userdb"
DB_PASS="just4tsika!"
DB_NAME="mydatabase"
DB_TABLE="glpi"

# 🗓️ Message d'information
echo "[$(date)] Démarrage de la suppression des anciens enregistrements..."

# 🚀 Exécute la requête SQL dans le conteneur MySQL via docker exec
docker exec -i $CONTAINER_MYSQL mysql -u $DB_USER -p"$DB_PASS" -D $DB_NAME -e "
DELETE FROM $DB_TABLE
WHERE 
  date_creation REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}([ ][0-9]{2}:[0-9]{2}:[0-9]{2})?\$'
  AND DATE(date_creation) <> CURDATE();
"

# 📊 Vérifie si la commande a réussi
if [ $? -eq 0 ]; then
  echo "[$(date)] ✔️ Suppression réussie."
else
  echo "[$(date)] ❌ Erreur lors de la suppression."
fi
