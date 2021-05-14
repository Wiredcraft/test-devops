FROM node:14-alpine

# Add for Express for improving performance
# See http://expressjs.com/en/advanced/best-practice-performance.html#set-node_env-to-production
ENV NODE_ENV production

WORKDIR /app

COPY package*.json .

# `npm ci` is faster than `npm install`
# See https://blog.npmjs.org/post/171556855892/introducing-npm-ci-for-faster-more-reliable
RUN npm ci

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
