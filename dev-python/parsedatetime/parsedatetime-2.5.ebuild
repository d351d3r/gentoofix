EAPI=6
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Parse human-readable date/time strings"
HOMEPAGE="https://github.com/bear/parsedatetime"
SRC_URI="https://github.com/bear/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/future[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare() {
	rm setup.cfg || die
}

python_test() {
	py.test || die
}
