#!bin/bash

# Path to the JSON file containing the manager IP and worker token
TOKEN_FILE="shared/token/join_token.json"

# Check if the JSON file exists
if [[ ! -f "$TOKEN_FILE" ]]; then
  echo "Error: JSON file not found at $TOKEN_FILE"
  exit 1
fi

# Parse manager IP and worker token from the JSON file using jq
MANAGER_IP=$(jq -r '.manager_ip' "$TOKEN_FILE")
WORKER_TOKEN=$(jq -r '.worker_token' "$TOKEN_FILE")

# Check if we successfully retrieved the values
if [[ -z "$MANAGER_IP" || -z "$WORKER_TOKEN" ]]; then
  echo "Error: Could not extract manager IP or worker token from $TOKEN_FILE"
  exit 1
fi

# Join the worker to the swarm
echo "Joining the worker to the swarm at $MANAGER_IP using the token $WORKER_TOKEN..."
docker swarm join --token "$WORKER_TOKEN" "$MANAGER_IP:2377"

echo "Worker node successfully joined the swarm!"
