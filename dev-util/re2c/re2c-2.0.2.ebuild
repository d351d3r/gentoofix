EAPI=7

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://re2c.org/"
SRC_URI="https://github.com/skvadrik/re2c/releases/download/${PV}/${P}.tar.xz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug"

src_configure() {
	econf \
		--enable-golang \
		ac_cv_path_BISON="no" \
		$(use_enable debug)
}

src_install() {
	default

	docompress -x /usr/share/doc/${PF}/examples
	dodoc -r README.md CHANGELOG examples
}
