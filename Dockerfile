# Stage 1: Install dependencies
FROM oven/bun:1.2-alpine AS builder
WORKDIR /app

# Menyalin package.json dan bun.lock
COPY package.json bun.lock ./

# Menginstal dependensi secara aman dan ketat
RUN bun install --frozen

# Menyalin seluruh source code proyek
COPY . .

# Stage 2: Runner stage yang aman dan minimalis
FROM oven/bun:1.2-alpine AS runner
WORKDIR /app

# Set env ke production
ENV NODE_ENV=production

# Menyalin dependensi dan source code hasil build dari stage builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/src ./src

# Menggunakan user non-root 'bun' bawaan image oven/bun demi keamanan
USER bun

# Membuka port internal container
EXPOSE 3000

# Menjalankan script menggunakan runtime Bun
CMD ["bun", "run", "src/index.ts"]