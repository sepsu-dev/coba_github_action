# Stage 1: Install dependencies & Build aplikasi
FROM oven-sh/setup-bun:1.1-alpine AS builder
WORKDIR /app

# Copy package files
COPY package.json bun.lockb ./
RUN bun install --frozen-lockfile

# Copy semua source code
COPY . .

# Set environment dummy untuk build time jika diperlukan
ENV NEXT_TELEMETRY_DISABLED=1
RUN bun run build

# Stage 2: Runner (Image akhir yang ringan)
FROM oven-sh/setup-bun:1.1-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Copy aset statis dan hasil build dari stage builder
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000

# Jalankan server Next.js (Standalone mode)
CMD ["bun", "src/index.js"]