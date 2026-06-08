# GANTI baris pertama dengan image resmi oven/bun berbasis alpine
FROM oven/bun:1.1-alpine AS builder
WORKDIR /app

# Copy file konfigurasi package
COPY package.json bun.lock ./

# Install semua dependencies
RUN bun install --frozen-lockfile

# Copy semua source code (termasuk folder src)
COPY . .

# Expose port (sesuaikan dengan port aplikasi Anda, misal 3000)
EXPOSE 3000

# Jalankan aplikasi TypeScript langsung menggunakan Bun
CMD ["bun", "run", "src/index.ts"]