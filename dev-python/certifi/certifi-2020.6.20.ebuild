EAPI="7"

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 prefix readme.gentoo-r1

DESCRIPTION="Python package for providing Mozilla's CA Bundle"
HOMEPAGE="https://certifi.io/ https://pypi.org/project/certifi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE=""

PATCHES=( "${FILESDIR}"/$P-use-system-cacerts.patch )

RDEPEND="app-misc/ca-certificates"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	distutils-r1_python_prepare_all

	eprefixify certifi/core.py
}

python_install_all() {
	distutils-r1_python_install_all

	local DOC_CONTENTS="
		In Gentoo, we don't use certifi's bundled CA certificates.
		Instead we remove bundled cacert.pem and patch certifi
		to return system's CA certificates.
	"
	readme.gentoo_create_doc

	find "${D}" -name 'cacert.pem' -delete || die "Failed to delete bundled CA certificates"
}
