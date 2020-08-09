EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A robust and significantly extended implementation of JSONPath for Python."
HOMEPAGE="https://github.com/kennknowles/python-jsonpath-rw https://pypi.org/project/jsonpath-rw/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]
		 dev-python/ply[${PYTHON_USEDEP}]
		 dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${REDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
