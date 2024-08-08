#!/bin/bash

# Ensure the PATH is correctly set
export PATH="/root/.cargo/bin:/root/.local/share/solana/install/active_release/bin:$PATH"

# Generate the Solana keypair if it doesn't exist
if [ ! -f /root/config/key/id.json ]; then
    solana-keygen new --outfile /root/config/key/id.json

    # Check if the keypair was generated successfully
    if [ $? -ne 0 ]; then
        echo "Error: Solana keygen failed"
        exit 1
    fi

    echo "Solana keypair generated successfully"
else
    echo "Solana keypair already exists, skipping generation"
fi
