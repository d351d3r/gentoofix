EAPI=7

PYTHON_COMPAT=( python3_{7..9} pypy3 )

inherit distutils-r1

DESCRIPTION="Python package to parse, read and write Microsoft OLE2 files"
HOMEPAGE="https://www.decalage.info/olefile"
SRC_URI="https://github.com/decalage2/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64"

distutils_enable_sphinx doc
distutils_enable_tests unittest

DEPEND="dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]"
