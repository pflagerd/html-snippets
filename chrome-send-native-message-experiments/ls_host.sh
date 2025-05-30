#!/bin/bash

# Read the message from Chrome (first 4 bytes is the length)
read -n 4 msg_length
msg_length=$(echo $msg_length | awk '{printf "%d", "0x"$1}')
read -n $msg_length msg

# Parse any arguments if sent
args=$(echo "$msg" | jq -r '.args[]' 2>/dev/null)

# Run ls with any provided arguments
output=$(/bin/ls $args 2>&1)

# Prepare the response
response=$(jq -n --arg output "$output" '{output: $output}')

# Send the response back to Chrome
response_length=$(printf "%08x" $(echo -n "$response" | wc -c))
echo -n "$response_length$response"
