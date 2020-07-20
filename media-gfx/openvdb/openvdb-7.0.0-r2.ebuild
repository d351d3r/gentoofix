EAPI=6

PYTHON_COMPAT=( python3_{7..9} )

inherit cmake-utils flag-o-matic python-single-r1

DESCRIPTION="Libs for the efficient manipulation of volumetric data"
HOMEPAGE="http://www.openvdb.org"
SRC_URI="https://github.com/AcademySoftwareFoundation/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc python test libglvnd"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	>=dev-libs/boost-1.72:=
	>=dev-libs/c-blosc-1.17.1
	dev-libs/jemalloc
	dev-libs/log4cplus
	media-libs/glfw:=
	media-libs/openexr:=
	sys-libs/zlib:=
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	libglvnd? ( media-libs/libglvnd )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			>=dev-libs/boost-1.72:=[python,numpy,${PYTHON_MULTI_USEDEP}]
			dev-python/numpy[${PYTHON_MULTI_USEDEP}]
		')
	)"

DEPEND="${RDEPEND}
	dev-cpp/tbb
	virtual/pkgconfig
	doc? ( app-doc/doxygen[doc] )
	test? ( dev-util/cppunit )"

#PATCHES=(
#	"${FILESDIR}/${PN}-7.0.0-remesh.patch"
#)

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local myprefix="${EPREFIX}/usr/"

	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="share/doc/${PF}"
		-DOPENVDB_ABI_VERSION_NUMBER=7
		-DOPENVDB_BUILD_DOCS=$(usex doc)
		-DOPENVDB_BUILD_PYTHON_MODULE=$(usex python)
		-DOPENVDB_BUILD_UNITTESTS=$(usex test)
		-DOPENVDB_ENABLE_RPATH=ON
		-DUSE_GLFW3=ON
		-DOPENVDB_CORE_STATIC=OFF
		-DUSE_NUMPY=ON
		-DOPENVDB_PYTHON_WRAP_ALL_GRID_TYPE=ON
	)
	if use libglvnd; then
		maycmakeargs+=( -DOpenGL_GL_PREFERENCE=GLVND )
	else
		maycmakeargs+=( -DOpenGL_GL_PREFERENCE=LEGACY )
	fi

	use python && mycmakeargs+=( -DPYOPENVDB_INSTALL_DIRECTORY="$(python_get_sitedir)" )
	use test && mycmakeargs+=( -DCPPUNIT_LOCATION="${myprefix}" )

	cmake-utils_src_configure
}
