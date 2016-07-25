module.exports =
  httpd:
    listen: process.env.HTTPD_LISTEN or "0.0.0.0:8080"

  mongodb:
    url: process.env.MONGODB_URL or "mongodb://db/demo"

