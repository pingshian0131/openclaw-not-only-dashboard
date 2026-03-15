FROM node:20-alpine

# Install Docker CLI (for docker exec to openclaw container)
RUN apk add --no-cache docker-cli

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci --omit=dev

# Copy source
COPY server.js ./
COPY public/ ./public/

EXPOSE 18790

# Run as node user so os.homedir() = /home/node (matches openclaw volume mounts)
USER node

CMD ["node", "server.js"]
