FROM rhel7.2:latest

MAINTAINER edseymour <edwaado@gmail.com>

RUN yum -y install dnsmasq && yum clean all
ADD start.sh /start.sh
ADD dnsmasq.conf /etc/dnsmasq.conf
RUN chmod u+x /start.sh

EXPOSE 53

CMD [ "/start.sh" ]

