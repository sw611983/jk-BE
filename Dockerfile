# ---- BUILD STAGE ----
FROM node:lts-alpine AS builder

# Install native build tools needed for bcrypt
RUN apk add --no-cache make gcc g++ python3

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy full app
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Build NestJS project
RUN npm run build

# ---- RUNTIME STAGE ----
FROM node:lts-alpine AS runner

WORKDIR /app

# Copy only what's needed for production
COPY --from=builder /app/package.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

# Expose the port your app runs on
EXPOSE 3000

# Run using the main entry point from dist/src
CMD ["node", "dist/src/main"]
