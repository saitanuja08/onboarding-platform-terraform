#!/bin/bash

# Set your API token and organization ID
API_TOKEN="YOUR_API_TOKEN"
ORGANIZATION_ID="your-organization-id"

# Create the Astronomer workspace
WORKSPACE_PAYLOAD='{
  "name": "MyWorkspace",
  "organization_id": "'"$ORGANIZATION_ID"'"
  # Add other workspace settings here
}'
WORKSPACE_RESPONSE=$(curl -X POST -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: application/json" -d "$WORKSPACE_PAYLOAD" https://api.astronomer.io/api/v0/workspace)

if [ "$(echo "$WORKSPACE_RESPONSE" | jq -r '.status')" == "success" ]; then
  echo "Workspace created successfully!"
  WORKSPACE_ID=$(echo "$WORKSPACE_RESPONSE" | jq -r '.data.id')

  # Create the entitlements
  ENTITLEMENTS_PAYLOAD='{
    "workspace_id": "'"$WORKSPACE_ID"'",
    "entitlements": [
      {
        "user_id": "user-id-1",
        "role": "viewer"
      },
      {
        "user_id": "user-id-2",
        "role": "editor"
      }
      # Add more entitlements as needed
    ]
  }'
  ENTITLEMENTS_RESPONSE=$(curl -X POST -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: application/json" -d "$ENTITLEMENTS_PAYLOAD" https://api.astronomer.io/api/v0/entitlements)

  if [ "$(echo "$ENTITLEMENTS_RESPONSE" | jq -r '.status')" == "success" ]; then
    echo "Entitlements created successfully!"
  else
    echo "Failed to create entitlements."
    echo "$ENTITLEMENTS_RESPONSE"
  fi
else
  echo "Failed to create workspace."
  echo "$WORKSPACE_RESPONSE"
fi
