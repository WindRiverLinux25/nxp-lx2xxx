COMPATIBLE_MACHINE:nxp-lx2xxx = "nxp-lx2xxx"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append:nxp-lx2xxx = " \
    file://0001-fsl-layerscape-soc-Fix-GIC-LPI-initialization-for-LX.patch \
"
