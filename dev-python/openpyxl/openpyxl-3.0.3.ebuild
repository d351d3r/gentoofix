EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Pure python reader and writer of Excel OpenXML files"
HOMEPAGE="https://openpyxl.readthedocs.io/en/stable/"
# Upstream doesn't want to include tests in PyPI tarballs
# https://bitbucket.org/openpyxl/openpyxl/issues/1308/include-tests-in-pypi-tarballs
SRC_URI="https://bitbucket.org/${PN}/${PN}/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/jdcal[${PYTHON_USEDEP}]
	dev-python/et_xmlfile[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP},tiff,jpeg]
	)"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	pytest -vv || die "Testing failed with ${EPYTHON}"
}
