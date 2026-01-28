FROM node:22-slim AS build
WORKDIR /app
COPY . .
RUN npm ci
RUN npx quartz build

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/* && rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/public /usr/share/nginx/html
