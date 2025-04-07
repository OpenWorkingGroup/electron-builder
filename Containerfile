# Containerfile for Angular + Electron builds
FROM node:20-slim as builder

# Setup environment for pnpm global binaries
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH=$PNPM_HOME:$PATH

# Enable pnpm via corepack
RUN corepack enable && corepack prepare pnpm@latest --activate

# Create PNPM global bin directory
RUN mkdir -p $PNPM_HOME

# Install global build tools
RUN pnpm add -g electron-builder @angular/cli

# Set working directory for pipeline steps
WORKDIR /workspace