FROM nginx:1.11.8

VOLUME ["/var/log/nginx"]
VOLUME ["/etc/nginx"]

ADD etc/nginx.conf /etc/nginx/nginx.conf
ADD scripts/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh
