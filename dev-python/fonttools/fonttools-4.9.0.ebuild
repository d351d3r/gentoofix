EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
PYTHON_REQ_USE="xml(+)"

inherit eutils distutils-r1
SRC_URI="mirror://githubcl/${PN}/${PN}/tar.gz/${PV} -> ${P}.tar.gz"
RESTRICT="primaryuri"
KEYWORDS="amd64"

DESCRIPTION="Library for manipulating TrueType, OpenType, AFM and Type1 fonts"
HOMEPAGE="https://github.com/${PN}/${PN}"

LICENSE="BSD"
SLOT="0"
IUSE="brotli gtk qt5 test +ufo unicode zopfli"
DOCS=( {README,NEWS}.rst )
PATCHES=(
	"${FILESDIR}"/${PN}-xattr.diff
)

# README.rst: Optional Requirements
RDEPEND="
	>=dev-python/lxml-4.5[${PYTHON_USEDEP}]
	brotli? ( dev-python/brotlipy[${PYTHON_USEDEP}] )
	zopfli? ( dev-python/py-zopfli[${PYTHON_USEDEP}] )
	ufo? (
		>=dev-python/fs-2.4.11[${PYTHON_USEDEP}]
	)
	unicode? (
		>=dev-python/unicodedata2-13[${PYTHON_USEDEP}]
	)
	qt5? ( dev-python/PyQt5[${PYTHON_USEDEP}] )
	gtk? ( dev-python/pygobject:3[${PYTHON_USEDEP}] )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		sci-libs/scipy[${PYTHON_USEDEP}]
		dev-python/ufoLib2[${PYTHON_USEDEP}]
	)
"
distutils_enable_tests pytest

pkg_postinst() {
	optfeature \
		"finding wrong contour/component order between different masters" \
		sci-libs/scipy
	optfeature \
		"visualizing DesignSpaceDocument and resulting VariationModel" \
		dev-python/matplotlib
	optfeature "symbolic font statistics analysis" dev-python/sympy
	optfeature "drawing glyphs as PNG images" dev-python/reportlab
}
