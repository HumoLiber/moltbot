FROM node:22-slim

# Create non-root user
RUN groupadd -r moltbot && useradd -r -g moltbot -m -s /bin/bash moltbot

# Install OpenClaw globally
RUN npm install -g openclaw

# Set working directory
WORKDIR /workspace

# Copy package.json for any local deps
COPY package.json ./

# Switch to non-root user
USER moltbot

# Workspace and channels will be mounted as volumes
# .openclaw/ -> /workspace/.openclaw (rw)
# channels/  -> /workspace/channels (rw)

CMD ["openclaw", "start"]
