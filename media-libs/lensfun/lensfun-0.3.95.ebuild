EAPI=6

PYTHON_COMPAT=( python3_{7..9} )

inherit python-single-r1 cmake-utils

DESCRIPTION="Library for rectifying and simulating photographic lens distortions"
HOMEPAGE="http://lensfun.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-3 CC-BY-SA-3.0" # See README for reasoning.
SLOT="0"
KEYWORDS="amd64"
IUSE="doc cpu_flags_x86_sse cpu_flags_x86_sse2 test"

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.40
	media-libs/libpng:0=
	sys-libs/zlib:="
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		dev-python/docutils
	)"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( README.md docs/mounts.txt ChangeLog )

PATCHES=( "${FILESDIR}"/apps_path.patch )

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="${EPREFIX}"/usr/share/doc/${PF}/html
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}"/usr/$(get_libdir)
		-DSETUP_PY_INSTALL_PREFIX="${ED}"/usr
		-DBUILD_LENSTOOL=ON
		-DBUILD_STATIC=OFF
		-DBUILD_DOC=$(usex doc)
		-DBUILD_FOR_SSE=$(usex cpu_flags_x86_sse)
		-DBUILD_FOR_SSE2=$(usex cpu_flags_x86_sse2)
		-DBUILD_TESTS=$(usex test)
	)

	cmake-utils_src_configure
}

src_test() {
	mkdir -p "${T}/db/lensfun" || die
	cp data/db/* "${T}/db/lensfun/" || die

	XDG_DATA_HOME="${T}/db" cmake-utils_src_test
}
