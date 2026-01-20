COMPATIBLE_MACHINE:nxp-lx2xxx = "nxp-lx2xxx"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:nxp-lx2xxx = "git://github.com/nxp-qoriq/dpdk;protocol=https;nobranch=1"
SRC_URI:append:nxp-lx2xxx = " \
            file://0001-meson.build-march-and-mcpu-already-passed-by-Yocto.patch \
"

MESON_BUILDTYPE:nxp-lx2xxx = "release"

PACKAGECONFIG:append:nxp-lx2xxx ??= "openssl"
PACKAGECONFIG[openssl] = ",,openssl"

DPDK_EXAMPLES:nxp-lx2xxx = "l2fwd,l3fwd,l2fwd-crypto,ipsec-secgw,ip_fragmentation,ip_reassembly,qdma_demo,timer,multi_process/simple_mp"
EXTRA_OEMESON:append:nxp-lx2xxx = " \
		-Denable_kmods=false \
		-Doptimization=3 \
		--cross-file ${S}/config/arm/arm64_poky_linux_gcc \
		-Denable_driver_sdk=true \
		${@bb.utils.contains('DISTRO_FEATURES', 'vpp', '-Dc_args="-Ofast -fPIC -ftls-model=local-dynamic"', '', d)} \
"

RDEPENDS:${PN}:append:nxp-lx2xxx = " bash python3-pyelftools"
RDEPENDS:${PN}:remove:nxp-lx2xxx = "kernel-module-dpdk-extras"

CVE_PRODUCT:nxp-ls1043 = "data_plane_development_kit"

do_install:append:nxp-lx2xxx(){
    install -d ${D}/${sysconfdir}/dpdk
    cp -rf ${S}/nxp/* ${D}/${sysconfdir}/dpdk
}
