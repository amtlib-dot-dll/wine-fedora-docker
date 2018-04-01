FROM fedora:26
RUN useradd -U -m user; \
    curl -o /etc/yum.repos.d/winehq.repo https://dl.winehq.org/wine-builds/fedora/26/winehq.repo; \
    dnf install -y winehq-stable; \
    dnf clean all; \
    curl -o /opt/wine-stable/share/wine/mono/wine-mono-4.7.1.msi -LJ https://dl.winehq.org/wine/wine-mono/4.7.1/wine-mono-4.7.1.msi; \
    curl -o /opt/wine-stable/share/wine/gecko/wine_gecko-2.47-x86_64.msi -LJ https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi; \
    curl -o /opt/wine-stable/share/wine/gecko/wine_gecko-2.47-x86.msi -LJ https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi
USER user
WORKDIR /home/user
