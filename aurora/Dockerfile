FROM debian:jessie

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN set -x && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends curl libaio1 pwgen openssl perl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -ksLo /mysql-5.6.10-debian6.0-x86_64.deb 'https://cdn.mysql.com/archives/mysql-5.6/mysql-5.6.10-debian6.0-x86_64.deb' && \
    dpkg -i /mysql-5.6.10-debian6.0-x86_64.deb && \
    rm /mysql-5.6.10-debian6.0-x86_64.deb

RUN /opt/mysql/server-5.6/scripts/mysql_install_db \
  --basedir=/opt/mysql/server-5.6 \
  --datadir=/opt/mysql/server-5.6/data \
  --plugin-dir=/opt/mysql/server-5.6/lib/plugin \
  --user=mysql \
  --log-error=/var/log/mysql/install_db_error.log

RUN mkdir -p /var/mysql && \
    mkdir -p /var/log/mysql && \
    mkdir -p /opt/mysql/server-5.6/data && \
    chown mysql /var/log/mysql&& \
    chown mysql /opt/mysql/server-5.6/data

RUN mkdir /schemas

USER mysql
WORKDIR /opt/mysql/server-5.6

COPY run.sh /opt/

RUN ./support-files/mysql.server start && \
    ./bin/mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '';" && \
    ./support-files/mysql.server stop

EXPOSE 3306
CMD ["/opt/run.sh"]

HEALTHCHECK CMD test -e /tmp/mysqlready.lock
