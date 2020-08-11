# BUILD Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# NOTE: The build folder will be created _in_ the working directory /app/build 
#(We want to copy this folder over to the RUN phase)

# RUN (Serve) Phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html