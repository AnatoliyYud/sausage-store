FROM node:16.13.2-alpine as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && \
    npm run build


FROM nginxproxy/nginx-proxy
COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html
COPY --from=builder /usr/src/app/nginx.tmpl /app/nginx.tmpl
EXPOSE 80
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]

