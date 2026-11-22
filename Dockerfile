# ==============================================================================
# CampusCash - Production Dockerfile for Google Cloud Run
# Multi-stage, node:20-alpine, non-root user, honors $PORT & 0.0.0.0
# ==============================================================================

# Stage 1: Dependency Installation
FROM node:20-alpine AS deps
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

# Stage 2: Runtime Production Container
FROM node:20-alpine AS runner
WORKDIR /usr/src/app

# Set production environment defaults
ENV NODE_ENV=production
ENV PORT=8080

# Copy production node_modules from deps stage
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY package*.json ./
COPY src/ ./src/
COPY public/ ./public/

# Security: Run as non-root user (built-in 'node' user in alpine, uid 1000)
USER node

# Expose default Cloud Run port (Cloud Run sets PORT env dynamically at runtime)
EXPOSE 8080

# Start server
CMD ["node", "src/server/server.js"]
