EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 eutils
MY_PN=pyfilesystem2
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
RESTRICT="primaryuri"
KEYWORDS="amd64"

DESCRIPTION="Filesystem abstraction layer"
HOMEPAGE="https://www.pyfilesystem.org"

LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	virtual/python-enum34[${PYTHON_USEDEP}]
	virtual/python-typing[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/scandir[${PYTHON_USEDEP}]' \
		python2_7)
	$(python_gen_cond_dep 'dev-python/backports-os[${PYTHON_USEDEP}]' \
		python2_7)
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pyftpdlib[${PYTHON_USEDEP},test]
		$(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' \
			python2_7)
	)
"

python_test() {
	esetup.py pytest
}

pkg_postinst() {
	optfeature "S3 support" dev-python/boto
	optfeature "SFTP support" dev-python/paramiko
	optfeature "Browser support" dev-python/wxpython
}
