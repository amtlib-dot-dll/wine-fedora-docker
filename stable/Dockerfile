FROM fedora:26
RUN useradd -U -m user; \
    curl -o /etc/yum.repos.d/winehq.repo https://dl.winehq.org/wine-builds/fedora/26/winehq.repo; \
    dnf install -y winehq-devel mesa-dri-drivers.x86_64 mesa-dri-drivers.i686 /usr/bin/ntlm_auth glibc-langpack-en langpacks-en glibc-langpack-zh langpacks-zh_CN langpacks-zh_TW; \
    dnf remove --noautoremove $(rpm -qa wine*); \
    dnf clean all; \
    cd /opt; \
    curl -vLOJ https://dl.winehq.org/wine/wine-mono/4.7.1/wine-mono-4.7.1.msi; \
    curl -vLOJ https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi; \
    curl -vLOJ https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi
RUN (while true; do sleep 300; id; done) & \
    dnf install -y winehq-stable; \
    dnf clean all; \
    mkdir -p /opt/wine-stable/share/wine/mono /opt/wine-stable/share/wine/gecko; \
    ln -t /opt/wine-stable/share/wine/mono /opt/wine-mono-4.7.1.msi; \
    ln -t /opt/wine-stable/share/wine/gecko /opt/wine_gecko-2.47-x86_64.msi; \
    ln -t /opt/wine-stable/share/wine/gecko /opt/wine_gecko-2.47-x86.msi
USER user
WORKDIR /home/user
