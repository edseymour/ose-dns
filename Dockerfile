FROM fedora:22

MAINTAINER edseymour <edwaado@gmail.com>

RUN dnf -y install dnsmasq && dnf clean all
ADD start.sh /start.sh
ADD dnsmasq.conf /etc/dnsmasq.conf
RUN chmod u+x /start.sh

EXPOSE 53

CMD [ "/start.sh" ]

