FROM debian:10

RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list

RUN apt update && apt install -y mariadb-server mariadb-client

RUN mkdir -p /var/data/db /var/run/mysqld && \
    chown -R mysql:mysql /var/data/db /var/run/mysqld

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/mysqld"]