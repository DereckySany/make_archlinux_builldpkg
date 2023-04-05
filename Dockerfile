FROM archlinux/base

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git

RUN useradd -m user
WORKDIR /home/user

USER user

RUN git clone https://github.com/DereckySany/make_archlinux_builldpkg.git
WORKDIR /home/user/make_archlinux_builldpkg

CMD makepkg -srif
