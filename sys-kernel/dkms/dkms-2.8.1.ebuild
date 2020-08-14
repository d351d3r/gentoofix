EAPI=7

inherit eutils bash-completion-r1

DESCRIPTION="Dynamic Kernel Module Support"
HOMEPAGE="https://github.com/dell/dkms"
SRC_URI="https://github.com/dell/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
DEPEND=""
RDEPEND=""
KEYWORDS="*"
SLOT="0"

src_compile() {
	return
}

src_install() {
	make DESTDIR="$D" install
}
