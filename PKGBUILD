# Maintainer: Laurent Carlier <lordheavym@gmail.com>
# Maintainer: Felix Yan <felixonmars@archlinux.org>
# Contributor: Jan de Groot <jgc@archlinux.org>
# Contributor: Andreas Radke <andyrtr@archlinux.org>
# Contributor: BlkSky <blksky@gmail.com>

pkgbase=mesa-blksky-git
pkgname=('vulkan-mesa-layers' 'opencl-mesa' 'vulkan-intel' 'vulkan-radeon' 'vulkan-swrast' 'vulkan-virtio' 'libva-mesa-driver' 'mesa-vdpau' 'mesa')
pkgdesc="An open-source implementation of the OpenGL specification"
pkgver=22.3.branchpoint.1961.ge4e4ba23047
pkgrel=1
arch=('x86_64')
makedepends=('python-mako' 'libxml2' 'libx11' 'xorgproto' 'libdrm' 'libxshmfence' 'libxxf86vm'
             'libxdamage' 'libvdpau' 'libva' 'wayland' 'wayland-protocols' 'zstd' 'elfutils' 'llvm'
             'libomxil-bellagio' 'libclc' 'clang' 'libglvnd' 'libunwind' 'lm_sensors' 'libxrandr'
             'systemd' 'valgrind' 'glslang' 'vulkan-icd-loader' 'directx-headers' 'cmake' 'meson')
makedepends+=('rust' 'rust-bindgen' 'spirv-tools' 'spirv-llvm-translator') # rusticl dependencies
makedepends+=('expat' 'git') # dependencies
url="https://www.mesa3d.org/"
license=('custom')
# source=("git+https://github.com/Mesa3D/mesa.git#branch=main")
source=("git+https://github.com/DereckySany/mesa.git#branch=main")
sha256sums=('SKIP')
b2sums=('SKIP')
validpgpkeys=('SKIP') # Eric Engestrom <eric@engestrom.ch>

prepare() {
  cd mesa

  # https://gitlab.freedesktop.org/drm/intel/-/issues/6851
  # https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/20449
#   export CFLAGS="-march=native -Os"
#   export CXXFLAGS="-march=native -Os"
  # https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/20449
  export CFLAGS="-march=native -m3dnow -m3dnowa -Os "
  export CXXFLAGS="-march=native -m3dnow -m3dnowa -Os "
}

build() {
  # Build only minimal debug info to reduce size
  CFLAGS+=' -g1'
  CXXFLAGS+=' -g1'

  arch-meson mesa build \
    -D b_ndebug=true \
    -D platforms=auto \
    -D gallium-drivers=r300,r600,radeonsi,nouveau,virgl,svga,swrast,i915,iris,crocus,zink,d3d12 \
    -D vulkan-drivers=amd,intel,intel_hasvk,swrast,virtio-experimental \
    -D vulkan-layers=device-select,intel-nullhw,overlay \
    -D shader-cache=auto \
    -D shader-cache-default=false \
    -D android-libbacktrace=disabled \
    -D dri3=enabled \
    -D egl=enabled \
    -D gallium-extra-hud=true \
    -D gallium-nine=true \
    -D gallium-omx=bellagio \
    -D gallium-opencl=icd \
    -D gallium-va=enabled \
    -D gallium-vdpau=enabled \
    -D gallium-xa=enabled \
    -D gallium-rusticl=true \
    -D rust_std=2021 \
    -D gbm=enabled \
    -D gles1=enabled \
    -D gles2=enabled \
    -D glx-read-only-text=true \
    -D glvnd=true \
    -D glx=dri \
    -D egl=enabled \
    -D vulkan-beta=false \
    -D glx-direct=true \
    -D xlib-lease=enabled \
    -D tools=glsl,intel \
    -D build-tests=false \
    -D opengl=true \
    -D libunwind=enabled \
    -D llvm=auto \
    -D shared-llvm=auto \
    -D draw-use-llvm=true \
    -D lmsensors=enabled \
    -D osmesa=true \
    -D shared-glapi=enabled \
    -D microsoft-clc=disabled \
    -D video-codecs=vc1dec,h264dec,h264enc,h265dec,h265enc \
    -D valgrind=enabled \
    -D optimization=s \
    -D c_cpp_args="-m3dnow -m3dnowa -Os "


  # Print config
  meson configure build \
    -D b_ndebug=true \
    -D platforms=auto \
    -D gallium-drivers=r300,r600,radeonsi,nouveau,virgl,svga,swrast,i915,iris,crocus,zink,d3d12 \
    -D vulkan-drivers=amd,intel,intel_hasvk,swrast,virtio-experimental \
    -D vulkan-layers=device-select,intel-nullhw,overlay \
    -D shader-cache=auto \
    -D shader-cache-default=false \
    -D android-libbacktrace=disabled \
    -D dri3=enabled \
    -D egl=enabled \
    -D gallium-extra-hud=true \
    -D gallium-nine=true \
    -D gallium-omx=bellagio \
    -D gallium-opencl=icd \
    -D gallium-va=enabled \
    -D gallium-vdpau=enabled \
    -D gallium-xa=enabled \
    -D gallium-rusticl=true \
    -D rust_std=2021 \
    -D gbm=enabled \
    -D gles1=enabled \
    -D gles2=enabled \
    -D glx-read-only-text=true \
    -D glvnd=true \
    -D glx=dri \
    -D egl=enabled \
    -D vulkan-beta=true \
    -D glx-direct=true \
    -D xlib-lease=enabled \
    -D tools=glsl,intel \
    -D build-tests=false \
    -D opengl=true \
    -D libunwind=enabled \
    -D llvm=auto \
    -D shared-llvm=auto \
    -D draw-use-llvm=true \
    -D lmsensors=enabled \
    -D osmesa=true \
    -D shared-glapi=enabled \
    -D microsoft-clc=disabled \
    -D video-codecs=vc1dec,h264dec,h264enc,h265dec,h265enc \
    -D valgrind=enabled \
    -D optimization=s \
    -D c_cpp_args="-m3dnow -m3dnowa -Os "

  ninja -C build
  meson compile -C build

  # fake installation to be seperated into packages
  # outside of fakeroot but mesa doesn't need to chown/mod
  DESTDIR="${srcdir}/fakeinstall" meson install -C build
}

_install() {
  local src f dir
  for src; do
    f="${src#fakeinstall/}"
    dir="${pkgdir}/${f%/*}"
    install -m755 -d "${dir}"
    mv -v "${src}" "${dir}/"
  done
}

package_vulkan-mesa-layers() {
  pkgdesc="Mesa's Vulkan layers"
  depends=('libdrm' 'libxcb' 'wayland' 'python')
  conflicts=('vulkan-mesa-layer')
  replaces=('vulkan-mesa-layer')

  _install fakeinstall/usr/share/vulkan/explicit_layer.d
  _install fakeinstall/usr/share/vulkan/implicit_layer.d
  _install fakeinstall/usr/lib/libVkLayer_*.so
  _install fakeinstall/usr/bin/mesa-overlay-control.py

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}

package_opencl-mesa() {
  pkgdesc="OpenCL support with clover and rusticl for mesa drivers"
  depends=('libdrm' 'libclc' 'clang' 'expat' 'spirv-llvm-translator')
  optdepends=('opencl-headers: headers necessary for OpenCL development')
  provides=('opencl-driver')

  _install fakeinstall/etc/OpenCL
  _install fakeinstall/usr/lib/lib*OpenCL*
  _install fakeinstall/usr/lib/gallium-pipe

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}

package_vulkan-intel() {
  pkgdesc="Intel's Vulkan mesa driver"
  depends=('wayland' 'libx11' 'libxshmfence' 'libdrm' 'zstd' 'systemd-libs')
  optdepends=('vulkan-mesa-layers: additional vulkan layers')
  provides=('vulkan-driver')

  _install fakeinstall/usr/share/vulkan/icd.d/intel_*.json
  _install fakeinstall/usr/lib/libvulkan_intel*.so

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}

package_vulkan-radeon() {
  pkgdesc="Radeon's Vulkan mesa driver"
  depends=('wayland' 'libx11' 'libxshmfence' 'libelf' 'libdrm' 'llvm-libs' 'systemd-libs')
  optdepends=('vulkan-mesa-layers: additional vulkan layers')
  provides=('vulkan-driver')

  _install fakeinstall/usr/share/drirc.d/00-radv-defaults.conf
  _install fakeinstall/usr/share/vulkan/icd.d/radeon_icd*.json
  _install fakeinstall/usr/lib/libvulkan_radeon.so

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}

package_vulkan-swrast() {
  pkgdesc="Vulkan software rasteriser driver"
  depends=('wayland' 'libx11' 'libxshmfence' 'libdrm' 'zstd' 'llvm-libs' 'systemd-libs' 'libunwind')
  optdepends=('vulkan-mesa-layers: additional vulkan layers')
  conflicts=('vulkan-mesa')
  replaces=('vulkan-mesa')
  provides=('vulkan-driver')

  _install fakeinstall/usr/share/vulkan/icd.d/lvp_icd*.json
  _install fakeinstall/usr/lib/libvulkan_lvp.so

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}

package_vulkan-virtio() {
  pkgdesc="Venus Vulkan mesa driver for Virtual Machines"
  depends=('wayland' 'libx11' 'libxshmfence' 'libdrm' 'zstd' 'systemd-libs')
  optdepends=('vulkan-mesa-layers: additional vulkan layers')
  provides=('vulkan-driver')

  _install fakeinstall/usr/share/vulkan/icd.d/virtio_icd*.json
  _install fakeinstall/usr/lib/libvulkan_virtio.so

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}

package_libva-mesa-driver() {
  pkgdesc="VA-API drivers"
  depends=('libdrm' 'libx11' 'llvm-libs' 'expat' 'libelf' 'libxshmfence')
  depends+=('libexpat.so')
  provides=('libva-driver')

  _install fakeinstall/usr/lib/dri/*_drv_video.so

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}

package_mesa-vdpau() {
  pkgdesc="VDPAU drivers"
  depends=('libdrm' 'libx11' 'llvm-libs' 'expat' 'libelf' 'libxshmfence')
  depends+=('libexpat.so')
  provides=('vdpau-driver')

  _install fakeinstall/usr/lib/vdpau

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}

package_mesa() {
  depends=('libdrm' 'wayland' 'libxxf86vm' 'libxdamage' 'libxshmfence' 'libelf'
           'libomxil-bellagio' 'libunwind' 'llvm-libs' 'lm_sensors' 'libglvnd'
           'zstd' 'vulkan-icd-loader')
  depends+=('libsensors.so' 'libexpat.so')
  optdepends=('opengl-man-pages: for the OpenGL API man pages'
              'mesa-vdpau: for accelerated video playback'
              'libva-mesa-driver: for accelerated video playback')
  provides=('mesa-libgl' 'opengl-driver')
  conflicts=('mesa-libgl')
  replaces=('mesa-libgl')

  _install fakeinstall/usr/share/drirc.d/00-mesa-defaults.conf
  _install fakeinstall/usr/share/glvnd/egl_vendor.d/50_mesa.json

  # ati-dri, nouveau-dri, intel-dri, svga-dri, swrast, swr
  _install fakeinstall/usr/lib/dri/*_dri.so
  _install fakeinstall/usr/bin/*

  _install fakeinstall/usr/lib/bellagio
  _install fakeinstall/usr/lib/d3d
  _install fakeinstall/usr/lib/lib{gbm,glapi}.so*
  _install fakeinstall/usr/lib/libOSMesa.so*
  _install fakeinstall/usr/lib/libxatracker.so*

  _install fakeinstall/usr/include
  _install fakeinstall/usr/lib/pkgconfig

  # libglvnd support
  _install fakeinstall/usr/lib/libGLX_mesa.so*
  _install fakeinstall/usr/lib/libEGL_mesa.so*
  _install fakeinstall/usr/lib/lib*so

  # indirect rendering
  ln -s /usr/lib/libGLX_mesa.so.0 "${pkgdir}/usr/lib/libGLX_indirect.so.0"

  # make sure there are no files left to install
  find fakeinstall -depth -print0 | xargs -0 rmdir

  install -m644 -Dt "${pkgdir}/usr/share/licenses/${pkgname}" LICENSE
}
