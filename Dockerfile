# Menggunakan image resmi Bun berbasis Alpine Linux yang sangat ringan
FROM oven/bun:1.2-alpine AS builder
WORKDIR /app

# Menyalin package.json dan bun.lock (format baru Bun v1.2+)
COPY package.json bun.lock ./

# Menginstal dependensi secara aman dan ketat menggunakan format baru
RUN bun install --frozen

# Menyalin seluruh source code proyek (termasuk folder src)
COPY . .

# Membuka port internal container (sesuaikan dengan port di src/index.ts Anda)
EXPOSE 3000

# Menjalankan script TypeScript langsung menggunakan runtime Bun
CMD ["bun", "run", "src/index.ts"]