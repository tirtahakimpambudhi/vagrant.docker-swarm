#!/bin/bash

# Starting manager
echo "Starting manager..."
MANAGER_IP=$(hostname -I | awk '{ print $2 }')
docker swarm init --advertise-addr $MANAGER_IP

echo "Retrieve manager token..."
TOKEN=$(docker swarm join-token -q worker)

# Create JSON output
echo "Storing the token and manager IP in JSON format..."

# Remove the old token file if it exists
if [ -f "shared/token/join_token.json" ]; then
  echo "File shared/token/join_token.json exists. Removing it..."
  rm -f shared/token/join_token.json
fi

# Create a JSON file with manager IP and worker token
cat <<EOF > shared/token/join_token.json
{
  "manager_ip": "$MANAGER_IP",
  "worker_token": "$TOKEN"
}
EOF

echo "Token and Manager IP saved to shared/token/join_token.json"
