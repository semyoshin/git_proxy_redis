FROM debian:jessie-slim

RUN apt-get update && apt-get install -y lua-nginx-redis
