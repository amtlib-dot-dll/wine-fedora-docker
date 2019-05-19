FROM fedora:29
RUN DLL_FILES=$(for dll in riched20 riched32 msls31 MSCTF MSCTFP wlanapi xmllite msxml msxml2 msxml3 msxml6 ole32 oleaut32 olepro32 comctl32 quartz pngfilt setupapi devenum; do echo WINDOWS/system32/$dll.dll; done); \
    curl -o /etc/yum.repos.d/winehq.repo https://dl.winehq.org/wine-builds/fedora/29/winehq.repo; \
    dnf install -y wine-stable64 wine-devel64 wine-staging64 $(dnf repoquery -q --requires winetricks | grep -v ^\( | grep -v ^wine) tigervnc-server glx-utils mesa-dri-drivers.x86_64 mesa-dri-drivers.i686 /usr/bin/ntlm_auth glibc-langpack-en langpacks-en glibc-langpack-zh langpacks-zh_CN langpacks-zh_TW p7zip-plugins libXt gtk2 gdk-pixbuf2 libXScrnSaver atk mesa-libGLU GConf2 ncurses-compat-libs libusb libcanberra; \
    dnf clean all; \
    chmod a+w,+t /home; \
    curl -vLo /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks; \
    chmod +x /usr/local/bin/winetricks; \
    mkdir -p /usr/share/wine/mono /usr/share/wine/gecko; \
    for branch in wine-mirror/wine/stable wine-mirror/wine/master PhoenicisOrg/winecx/winecx-18.1.0; do \
        curl -vL -o /tmp/addons.c https://raw.githubusercontent.com/$branch/dlls/appwiz.cpl/addons.c; \
        MONO_VERSION=$(eval "echo $(awk '$1 == "#define" && $2 == "MONO_VERSION" {print $3}' /tmp/addons.c)"); \
        GECKO_VERSION=$(eval "echo $(awk '$1 == "#define" && $2 == "GECKO_VERSION" {print $3}' /tmp/addons.c)"); \
        rm /tmp/addons.c; \
        cd /usr/share/wine/mono; \
        curl -vLOJ https://dl.winehq.org/wine/wine-mono/$MONO_VERSION/wine-mono-$MONO_VERSION.msi; \
        cd /usr/share/wine/gecko; \
        curl -vLOJ https://dl.winehq.org/wine/wine-gecko/$GECKO_VERSION/wine_gecko-$GECKO_VERSION-x86_64.msi; \
        curl -vLOJ https://dl.winehq.org/wine/wine-gecko/$GECKO_VERSION/wine_gecko-$GECKO_VERSION-x86.msi; \
    done; \
    mkdir -p /opt/wine-cx; \
    cd /opt/wine-cx; \
    curl -vL https://www.playonlinux.com/wine/binaries/phoenicis/cx-linux-amd64/PlayOnLinux-winecx-18.1.0-cx-linux-amd64.tar.gz | tar -xzf -; \
    cd /tmp; \
    curl -O https://download.microsoft.com/download/D/7/A/D7AD3FF8-2618-4C10-9398-2810DDE730F7/WindowsXPMode_zh-cn.exe; \
    curl -O https://download.microsoft.com/download/B/9/3/B93CD319-CD5A-41C8-9577-39F68D5E8009/WindowsXPMode_zh-tw.exe; \
    curl -O https://download.microsoft.com/download/7/2/C/72C7BAB7-2F32-4530-878A-292C20E1845A/WindowsXPMode_en-us.exe; \
    for alg in md5 sha1 sha256 sha512; do \
        ${alg}sum WindowsXPMode_??-??.exe 1>&2; \
    done; \
    for lcid in zh-cn zh-tw en-us; do \
        7z e -tcab WindowsXPMode_$lcid.exe sources/xpm; \
        rm WindowsXPMode_$lcid.exe; \
        7z e -tcab xpm VirtualXPVHD; \
        rm xpm; \
        mkdir /opt/$lcid; \
        7z e VirtualXPVHD -o/opt/$lcid $DLL_FILES; \
        rm VirtualXPVHD; \
    done
