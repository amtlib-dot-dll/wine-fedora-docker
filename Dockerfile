FROM fedora:30
RUN script.sh
USER user
WORKDIR /home/user
