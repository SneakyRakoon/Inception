FROM debian:bullseye-slim

RUN apt update -y && \
	apt install -y nginx

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
