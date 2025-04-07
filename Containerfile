# Containerfile for Angular + Electron builds
# ----------------------------------------
# Stage 1: Build environment with all tools
# ----------------------------------------
    FROM node:18 as builder

    # Setup environment for pnpm global binaries
    ENV PNPM_HOME=/root/.local/share/pnpm
    ENV PATH=$PNPM_HOME:$PATH
    
    # Enable pnpm via corepack
    RUN corepack enable && corepack prepare pnpm@latest --activate
    
    # Create PNPM global bin directory
    RUN mkdir -p $PNPM_HOME
    
    # Install global build tools
    RUN pnpm add -g electron-builder @angular/cli
    
    # ----------------------------------------
    # Stage 2: Runtime build container
    # ----------------------------------------
    FROM node:18-slim
    
    # Setup environment again for PNPM
    ENV PNPM_HOME=/root/.local/share/pnpm
    ENV PATH=$PNPM_HOME:$PATH
    
    # Copy tools from builder stage
    COPY --from=builder /root/.local/share/pnpm /root/.local/share/pnpm
    COPY --from=builder /root/.local/share/pnpm-global /root/.local/share/pnpm-global
    COPY --from=builder /usr/local/lib/node_modules /usr/local/lib/node_modules
    COPY --from=builder /usr/local/bin /usr/local/bin
    
    # Set working directory for pipeline steps
    WORKDIR /workspace