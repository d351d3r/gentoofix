EAPI=6
PYTHON_COMPAT=( python3_{7..9} )

inherit autotools python-single-r1

DESCRIPTION="IlmBase Python bindings"
HOMEPAGE="https://www.openexr.com"

MY_PN="openexr"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://githubcl/AcademySoftwareFoundation/${MY_PN}/tar.gz/v${PV} -> ${MY_P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64"
IUSE="+numpy"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	~media-libs/ilmbase-${PV}:=
	$(python_gen_cond_dep '
		>=dev-libs/boost-1.70.0[python(+),${PYTHON_MULTI_USEDEP}]
		numpy? ( >=dev-python/numpy-1.10.4[${PYTHON_MULTI_USEDEP}] )
	')"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	>=virtual/pkgconfig-0-r1"

PATCHES=(
	"${FILESDIR}/${PN}-2.3.0-link-pyimath.patch"
	"${FILESDIR}/${PN}-2.4.0-fix-build-system.patch"
)

DOCS=( README.md )

S="${WORKDIR}/${MY_P}/PyIlmBase"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local boostpython_ver="${EPYTHON:6}"
	if has_version ">=dev-libs/boost-1.70.0"; then
		boostpython_ver="${boostpython_ver/./}"
	else
		boostpython_ver="-${boostpython_ver}"
	fi

	local myeconfargs=(
		--with-boost-include-dir="${EPREFIX}/usr/include/boost"
		--with-boost-lib-dir="${EPREFIX}/usr/$(get_libdir)"
		--with-boost-python-libname="boost_python${boostpython_ver}"
		$(use_with numpy)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	# Fails to install with multiple jobs
	emake DESTDIR="${D}" -j1 install

	einstalldocs

	# package provides pkg-config files
	find "${D}" -name '*.la' -delete || die
}
