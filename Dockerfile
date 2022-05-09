FROM alpine:latest
COPY api-app /app/api-app
EXPOSE 8080
ENTRYPOINT [ "/app/api-app" ]