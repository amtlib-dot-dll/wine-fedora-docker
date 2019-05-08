FROM fedora:30
RUN /tmp/script.sh
USER user
WORKDIR /home/user
