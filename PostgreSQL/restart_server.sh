#!/bin/bash

# Define PostgreSQL installation paths
PG_CTL="/Library/PostgreSQL/17/bin/pg_ctl"
DATA_DIR="/Library/PostgreSQL/17/data"

# Restart PostgreSQL server
echo "Restarting PostgreSQL server without password prompt..."
sudo -u postgres $PG_CTL -D $DATA_DIR restart

# Verify the server status
echo "Checking PostgreSQL server status..."
sudo -u postgres $PG_CTL -D $DATA_DIR status
