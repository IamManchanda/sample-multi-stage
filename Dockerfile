# Production
FROM node:10-slim as prod

ENV NODE_ENV=production

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production && npm cache clean --force

COPY . .

CMD ["node", "./bin/www"]

# Development
FROM prod as dev

ENV NODE_ENV=development

RUN npm install --only=development

CMD ["node_modules/nodemon/bin/nodemon.js",  "./bin/www", "--inspect=0.0.0.0:9229"]

# Test
FROM dev as test

ENV NODE_ENV=development

CMD ["npm", "test"]
