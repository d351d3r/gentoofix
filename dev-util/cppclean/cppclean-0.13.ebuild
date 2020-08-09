EAPI=6

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Find problems in C++ source that slow development of large code bases"
HOMEPAGE="https://github.com/myint/cppclean"
SRC_URI="https://github.com/myint/cppclean/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
