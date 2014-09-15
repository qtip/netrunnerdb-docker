FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server

RUN apt-get install -y git-core php5 curl php5-intl php5-mysql
RUN git clone https://github.com/Alsciende/netrunnerdb.git
RUN cd /netrunnerdb && curl -s http://getcomposer.org/installer | php
RUN cd /netrunnerdb && php composer.phar install
ADD parameters.yml /netrunnerdb/app/config/

RUN git clone https://github.com/Alsciende/netrunnerdb-cards.git

ADD supervisor.conf /supervisor.conf

ADD bin/db /usr/bin/
RUN chmod 777 /usr/bin/db

ADD bin/serve /usr/bin/
RUN chmod 777 /usr/bin/serve

VOLUME ["/var/lib/mysql"]

CMD db ; serve

EXPOSE 80
