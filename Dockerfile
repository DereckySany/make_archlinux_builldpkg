FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm \
       base-devel \
       git \
       wget \
       jq \
    && pacman -Scc --noconfirm
COPY PKGBUILD /PKGBUILD

RUN useradd -m -G wheel user \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user \
    && chown -R user:user /PKGBUILD

USER user

RUN wget "https://github.com/DereckySany/make_archlinux_builldpkg/blob/main/PKGBUILD" \
    && ls \
    && makepkg -srif --syncdeps --noconfirm

CMD ["/bin/bash"]
