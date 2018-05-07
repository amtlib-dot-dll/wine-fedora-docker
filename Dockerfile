FROM fedora:27
RUN useradd -U -m user; \
    curl -o /etc/yum.repos.d/winehq.repo https://dl.winehq.org/wine-builds/fedora/27/winehq.repo; \
    dnf install -y winehq-devel $(dnf repoquery -q --requires winetricks | grep -v ^wine) glx-utils mesa-dri-drivers.x86_64 mesa-dri-drivers.i686 /usr/bin/ntlm_auth glibc-langpack-en langpacks-en glibc-langpack-zh langpacks-zh_CN langpacks-zh_TW p7zip-plugins; \
    dnf clean all; \
    curl -vLo /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks; \
    chmod +x /usr/local/bin/winetricks; \
    mkdir -p /opt/wine-devel/share/wine/mono /opt/wine-devel/share/wine/gecko; \
    cd /opt/wine-devel/share/wine/mono; \
    curl -vLOJ https://dl.winehq.org/wine/wine-mono/4.7.1/wine-mono-4.7.1.msi; \
    cd /opt/wine-devel/share/wine/gecko; \
    curl -vLOJ https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi; \
    curl -vLOJ https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi; \
    cd /tmp; \
    curl -O https://download.microsoft.com/download/D/7/A/D7AD3FF8-2618-4C10-9398-2810DDE730F7/WindowsXPMode_zh-cn.exe; \
    7z e -tcab WindowsXPMode_zh-cn.exe sources/xpm; \
    rm WindowsXPMode_zh-cn.exe; \
    7z e -tcab xpm VirtualXPVHD; \
    rm xpm; \
    mkdir /opt/winxp; \
    cd /opt/winxp; \
    7z e /tmp/VirtualXPVHD WINDOWS/system32/*.dll; \
    7z e /tmp/VirtualXPVHD WINDOWS/Fonts/*.*; \
    rm /tmp/VirtualXPVHD
USER user
WORKDIR /home/user
