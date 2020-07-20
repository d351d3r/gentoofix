EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit cmake-utils python-single-r1

SRC_URI="https://github.com/wdas/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

DESCRIPTION="Library for particle IO and manipulation"
HOMEPAGE="https://www.disneyanimation.com/technology/partio.html"

LICENSE="BSD"
SLOT="0"
IUSE="doc"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	dev-lang/swig
	doc? ( app-doc/doxygen[doc] )
"
RDEPEND="${PYTHON_DEPS}
	media-libs/freeglut
	sys-libs/zlib
	virtual/opengl
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package doc Doxygen)
	)
	cmake-utils_src_configure
}
