# Stage 1: build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
ARG VITE_API_VENTAS_URL=http://localhost:8080
ARG VITE_API_DESPACHOS_URL=http://localhost:8081
ENV VITE_API_VENTAS_URL=$VITE_API_VENTAS_URL
ENV VITE_API_DESPACHOS_URL=$VITE_API_DESPACHOS_URL
RUN npm run build

# Stage 2: nginx + reverse proxy (runtime env via envsubst)
FROM nginx:1.27-alpine AS runtime
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --from=builder /app/dist /usr/share/nginx/html
ENV VENTAS_UPSTREAM=http://host.docker.internal:8080
ENV DESPACHOS_UPSTREAM=http://host.docker.internal:8081
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
