From node:20
WORKDIR /app
COPY . .
RUN npm config set registry https://registry.npmmirror.com
RUN npm install
EXPOSE 3002
CMD ["npm","start"]