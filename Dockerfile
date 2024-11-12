FROM node:23 AS builder
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app
COPY . .
RUN pnpm install
RUN pnpm build:pkg
RUN pnpm build

FROM joseluisq/static-web-server:2-alpine AS runtime
WORKDIR /var/public
COPY --from=builder /app/site/.output/public .
ENV SERVER_ROOT=/var/public
