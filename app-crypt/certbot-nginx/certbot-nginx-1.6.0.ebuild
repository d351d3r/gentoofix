EAPI=7
PYTHON_COMPAT=(python3_{7..9})

SRC_URI="https://github.com/${PN%-nginx}/${PN%-nginx}/archive/v${PV}.tar.gz -> ${PN%-nginx}-${PV}.tar.gz"
KEYWORDS="amd64 arm64"
S=${WORKDIR}/${PN%-nginx}-${PV}/${PN}

inherit distutils-r1

DESCRIPTION="Nginx plugin for certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	>=app-crypt/acme-1.4.0[${PYTHON_USEDEP}]
	>=app-crypt/certbot-1.6.0[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-1.5.5[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"
