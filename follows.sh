#!/bin/bash
BEARER_TOKEN=$(cat token.txt)
HOSTNAME="your.mastodon.instance"
ACCOUNT_ID=$(curl -s -H "Authorization: Bearer $BEARER_TOKEN" https://$HOSTNAME/api/v1/accounts/verify_credentials | jq -r '.id')
NEXT_URL="https://$HOSTNAME/api/v1/accounts/$ACCOUNT_ID/following?limit=80"
while [ ! -z "$NEXT_URL" ]; do
  # Fetch the data and headers
  RESPONSE=$(curl -sS -i -H "Authorization: Bearer $BEARER_TOKEN" "$NEXT_URL")
  
  # Extract the data (body) and print the 'acct' field
  echo "$RESPONSE" | sed -n '/^\[/,$p' | jq -r '.[].acct'
  
  # Extract the Link header and find the next page URL
  NEXT_URL=$(echo "$RESPONSE" | grep "^link:" | sed -n 's/.*<\([^>]*\)>; rel="next".*/\1/p')
done
