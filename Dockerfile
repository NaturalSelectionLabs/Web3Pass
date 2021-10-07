FROM node:16-alpine AS base

WORKDIR /pass

FROM base AS builder

COPY . ./

RUN npm install
RUN npm build

FROM base AS runner

COPY --from=builder /pass/node_modules ./node_modules
COPY --from=builder /pass/dist ./dist
COPY package.json ./

CMD ["npm", "run", "serv"]
