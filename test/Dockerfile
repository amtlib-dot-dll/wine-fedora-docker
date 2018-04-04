FROM fedora:26
RUN useradd -U -m user; \
    curl -o /etc/yum.repos.d/winehq.repo https://dl.winehq.org/wine-builds/fedora/26/winehq.repo; \
    dnf install -y winehq-devel mesa-dri-drivers.x86_64 mesa-dri-drivers.i686 /usr/bin/ntlm_auth glibc-langpack-en langpacks-en glibc-langpack-zh langpacks-zh_CN langpacks-zh_TW; \
    dnf clean all; \
    mkdir -p /opt/wine-devel/share/wine/mono /opt/wine-devel/share/wine/gecko; \
    cd /opt/wine-devel/share/wine/mono; \
    curl -vLOJ https://dl.winehq.org/wine/wine-mono/4.7.1/wine-mono-4.7.1.msi; \
    cd /opt/wine-devel/share/wine/gecko; \
    curl -vLOJ https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi; \
    curl -vLOJ https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi
USER user
WORKDIR /home/user
