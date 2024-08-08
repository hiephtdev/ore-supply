#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure PATH is set correctly
export PATH="/root/.cargo/bin:/root/.local/share/solana/install/active_release/bin:$PATH"

# Run the keypair generation script
# /root/app/target/release/generate_keypair

# Run the keypair generation script
# ./root/generate_keypair.sh

# Run the main command
exec /root/.cargo/bin/ore mine --threads "$THREADS" --rpc "$RPC" --keypair "$KEYPAIR_FILEPATH" --buffer-time "$BUFFER_TIME"
