FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm \
        base-devel \
        git \
        wget \
        jq \
    && pacman -Scc --noconfirm

RUN useradd -m -G wheel user \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

USER user

WORKDIR /home/user

RUN git clone https://github.com/DereckySany/make_archlinux_builldpkg.git

WORKDIR /home/user/make_archlinux_builldpkg

RUN makepkg -srif --syncdeps --noconfirm

CMD ["/bin/bash"]
