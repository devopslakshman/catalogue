FROM node:20.20.2-alpine3.23 AS builder
WORKDIR /app
COPY package.json package-lock.json ./
COPY *.js .
RUN npm ci --omit=dev

FROM node:20.20.2-alpine3.23
WORKDIR /app
EXPOSE 8080
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop && \
    apk --no-cache update && apk --no-cache upgrade
COPY --from=builder /app /app
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
RUN chown -R roboshop:roboshop /app
USER roboshop
CMD ["server.js"]
ENTRYPOINT ["node"]
