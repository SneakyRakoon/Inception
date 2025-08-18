from debian:bullseye-slim

RUN apt update -y && \
	apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/50-server.cnf

EXPOSE 3306

CMD ["mysqld"]