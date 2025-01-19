Here’s a bash script that automates the steps to restart PostgreSQL on macOS, assuming PostgreSQL is installed in `/Library/PostgreSQL/17/`:

---

### **restart_postgresql.sh**
```bash
#!/bin/bash

# Define PostgreSQL installation paths
PG_CTL="/Library/PostgreSQL/17/bin/pg_ctl"
DATA_DIR="/Library/PostgreSQL/17/data"

# Check if the script is run as root
if [ "$(id -u)" -eq 0 ]; then
  echo "Do not run this script as root. Switching to the 'postgres' user."
  sudo -u postgres bash <<EOF
    echo "Restarting PostgreSQL server..."
    $PG_CTL -D $DATA_DIR restart
EOF
else
  echo "Switching to the 'postgres' user to restart PostgreSQL."
  su - postgres -c "$PG_CTL -D $DATA_DIR restart"
fi

# Verify the server status
echo "Checking PostgreSQL server status..."
sudo -u postgres $PG_CTL -D $DATA_DIR status
```

---

### **How to Use the Script**

1. **Save the Script**:
   Save the script as `restart_postgresql.sh` in a directory of your choice.

2. **Make it Executable**:
   Run the following command to give the script execution permissions:
   ```bash
   chmod +x restart_server.sh
   ```

3. **Run the Script**:
   Execute the script in your terminal:
   ```bash
   ./restart_server.sh
   ```

---

### **What the Script Does**
1. **Switch to the `postgres` User**:
   Ensures the script runs commands as the PostgreSQL service owner (`postgres`).

2. **Restart PostgreSQL**:
   Uses `pg_ctl` to stop and start the server.

3. **Check Server Status**:
   Verifies if the PostgreSQL server is running after the restart.

4. **Prevents Root Execution**:
   Avoids running PostgreSQL commands as the root user, ensuring security.

---

## Permissions

The issue lies in the permissions of the directory `../../..`, which is:

```plaintext
drwxr-x---+ 46 mihai  staff  1472 18 Jan 16:40 ../../..
```

This directory restricts **"others" (non-owner and non-group members)** from accessing it, as indicated by the `---` in the permissions for "others."

---

### **How to Fix**

#### **Option 1: Adjust Permissions for `../../..`**
To ensure the `postgres` user can access the directory, grant **execute (`x`) permissions** for "others" on `../../..`:
```bash
sudo chmod o+x ../../..
```

This will make the permissions look like:
```plaintext
drwxr-x--x
```
Now, the `postgres` user can resolve the working directory path.

---

#### **Option 2: Add `postgres` to the `staff` Group**
Since the directory belongs to the `staff` group, adding `postgres` to the `staff` group will also resolve the issue:
1. Add `postgres` to the `staff` group:
   ```bash
   sudo dseditgroup -o edit -a postgres -t user staff
   ```
2. Verify the user was added:
   ```bash
   dseditgroup -o checkmember -m postgres staff
   ```

After adding `postgres` to the `staff` group, the `postgres` user will inherit the group permissions (`r-x`).

---

#### **Option 3: Use a Temporary Working Directory**
If changing permissions is not desirable, modify the script to use a directory accessible to the `postgres` user (e.g., `/tmp`):

Add this line at the start of your script:
```bash
cd /tmp || exit
```

---

### **Recommended Approach**
- If you control access to the directory, **Option 1 (chmod o+x)** is the simplest and most direct solution.
- If you prefer managing access via groups, **Option 2** is a cleaner approach for long-term usability.

After applying the fix, rerun your script to confirm the issue is resolved.

# Note: 
used Option 2
