# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.cargo/bin:/root/.local/share/solana/install/active_release/bin:$PATH"

# Install necessary dependencies
RUN apt update && apt upgrade -y && \
    apt install -y build-essential curl

# Install Rust and Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Solana CLI
RUN sh -c "$(curl -sSfL https://release.solana.com/stable/install)" 

# Source .bashrc to update PATH for subsequent commands and update Rust
RUN . /root/.cargo/env && rustup update

# Install ore-cli using Cargo
RUN cargo install ore-cli

# Create necessary directories with proper permissions
RUN mkdir -p /root/config/key && chmod -R 777 /root/config/key

# Copy the entrypoint script
COPY generate_keypair.sh /root/generate_keypair.sh
RUN chmod +x /root/generate_keypair.sh

# Copy the entrypoint script
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

# Define the environment variables (these should be replaced with actual values or passed during docker run)
ENV THREADS 2
ENV RPC "https://api.mainnet-beta.solana.com"
ENV KEYPAIR_FILEPATH "/root/config/key/id.json"
ENV BUFFER_TIME 5
ENV UPDATE_INTERVAL 15

# Set the entrypoint to the entrypoint script
ENTRYPOINT ["/root/entrypoint.sh"]
