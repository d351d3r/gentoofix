EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Optimized Einsum: A tensor contraction order optimizer"
HOMEPAGE="https://pypi.org/project/opt-einsum/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P/-/_}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
S="${WORKDIR}/${P/-/_}"

BDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
