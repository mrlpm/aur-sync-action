FROM archlinux

RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xf "$patched_glibc" && pacman -Syu --noconfirm \
    --needed openssh sudo \
    git fakeroot binutils go-pie gcc awk binutils xz \
    libarchive bzip2 coreutils file findutils \
    gettext grep gzip sed ncurses jq

RUN useradd -ms /bin/bash builder && \
    echo 'builder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    mkdir -p /home/builder/.ssh && \
    touch /home/builder/.ssh/known_hosts

COPY ssh_config /home/builder/.ssh/config

RUN chown builder:builder /home/builder -R && \
    chmod 600 /home/builder/.ssh/* -R

COPY entrypoint.sh /entrypoint.sh

USER builder
WORKDIR /home/builder

ENTRYPOINT ["/entrypoint.sh"]

