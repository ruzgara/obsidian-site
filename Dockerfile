FROM node:22-slim AS build
WORKDIR /app
COPY . .
RUN npm ci
RUN npx quartz build

FROM nginx:alpine
COPY --from=build /app/public /usr/share/nginx/html
