EAPI=7
PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/plinss/${PN}.git"

inherit ${_scm} python-r1

DESCRIPTION="Certificate manager bot using ACME protocol"
HOMEPAGE="https://github.com/plinss/acmebot"
SRC_URI="https://github.com/plinss/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CDEPEND="${PYTHON_DEPS}
	>=dev-python/appdirs-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.8[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.5.0[${PYTHON_USEDEP}]
	>=dev-python/pydns-3.1.0:3[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-0.24.0[${PYTHON_USEDEP}]
	>=app-crypt/acme-0.25.1[${PYTHON_USEDEP}]
	"
RDEPEND="${CDEPEND}"
DEPEND=""

src_install() {
	python_foreach_impl python_doscript acmebot
	insinto /etc/logrotate.d
	doins logrotate.d/acmebot
	insinto /etc/acmebot
	doins acmebot.example.json
	dodoc README.rst
}
