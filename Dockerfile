FROM fedora:26
RUN useradd -U -m user; \
    curl -o /etc/yum.repos.d/winehq.repo https://dl.winehq.org/wine-builds/fedora/26/winehq.repo; \
    dnf install winehq-stable; \
    dnf clean all
USER user
WORKDIR /home/user
