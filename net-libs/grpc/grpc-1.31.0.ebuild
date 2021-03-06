EAPI=7

inherit cmake

MY_PV="${PV//_pre/-pre}"

DESCRIPTION="Modern open source high performance RPC framework"
HOMEPAGE="https://www.grpc.io"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc examples libressl"

DEPEND="
	=dev-cpp/abseil-cpp-20200225*:=
	>=dev-libs/protobuf-3.11.2:=
	>=net-dns/c-ares-1.15.0:=
	>=dev-libs/re2-0.2020.08.01:=
	sys-libs/zlib:=
	!libressl? ( >=dev-libs/openssl-1.0.2:0=[-bindist] )
	libressl? ( dev-libs/libressl:0= )
"

RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

# requires git checkouts of google tools
RESTRICT="test"

PATCHES=(
	"${FILESDIR}/findre2.patch"
	"${FILESDIR}/re2test.patch"
)

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	cmake_src_prepare

	# un-hardcode libdir
	sed -i "s@lib/pkgconfig@$(get_libdir)/pkgconfig@" CMakeLists.txt || die
	sed -i "s@/lib@/$(get_libdir)@" cmake/pkg-config-template.pc.in || die
	sed -i "s@re2 REQUIRED CONFIG@re2 REQUIRED@" cmake/re2.cmake || die
}

src_configure() {
	local mycmakeargs=(
		-DgRPC_INSTALL=ON
		-DgRPC_INSTALL_CMAKEDIR="$(get_libdir)/cmake/${PN}"
		-DgRPC_INSTALL_LIBDIR="$(get_libdir)"
		-DgRPC_ABSL_PROVIDER=package
		-DgRPC_CARES_PROVIDER=package
		-DgRPC_PROTOBUF_PROVIDER=package
		-DgRPC_SSL_PROVIDER=package
		-DgRPC_ZLIB_PROVIDER=package
		-DgRPC_RE2_PROVIDER=package
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use examples; then
		find examples -name '.gitignore' -delete || die
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	if use doc; then
		find doc -name '.gitignore' -delete || die
		local DOCS=( AUTHORS CONCEPTS.md README.md TROUBLESHOOTING.md doc/. )
	fi

	einstalldocs
}
