EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1
MY_PV="$(ver_rs 3 -)"
SRC_URI="mirror://githubcl/mikekap/${PN}/tar.gz/${MY_PV} -> ${P}.tar.gz"
RESTRICT="primaryuri"
KEYWORDS="amd64"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="Unicodedata backport for python 2/3 updated to the latest unicode version"
HOMEPAGE="https://github.com/mikekap/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

RDEPEND="
"
DEPEND="
	${RDEPEND}
"
distutils_enable_tests pytest
