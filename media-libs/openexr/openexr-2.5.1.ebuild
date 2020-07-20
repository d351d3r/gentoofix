EAPI=7

inherit cmake-utils

DESCRIPTION="ILM's OpenEXR high dynamic-range image file format libraries"
HOMEPAGE="http://openexr.com/"

SRC_URI="mirror://githubcl/AcademySoftwareFoundation/${MY_PN}/tar.gz/v${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/25" # based on SONAME

KEYWORDS="amd64"

IUSE="cpu_flags_x86_avx examples static-libs test"

RDEPEND="
	>=media-libs/ilmbase-${PV}:=
	sys-libs/zlib
"

DOCS=( README.md )

S="${WORKDIR}/${P}/OpenEXR"

src_prepare() {
	cmake-utils_src_prepare

	# Fix path for testsuite
	sed -i -e "s:/var/tmp/:${T}:" IlmImfTest/tmpDir.h || die

	sed -i -e "/symlink/d" config/LibraryDefine.cmake || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_INSTALL_INCLUDEDIR=include
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)
		-DOPENEXR_BUILD_BOTH_STATIC_SHARED=$(usex static-libs)
		-DBUILD_TESTING=$(usex test)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
	else
		rm -rf "${ED%/}"/usr/share/doc/${PF}/examples || die
	fi

	into /usr/$(get_libdir)
	dosym libIlmImf-2_5.so		/usr/$(get_libdir)/libIlmImf.so
	dosym libIlmImfUtil-2_5.so	/usr/$(get_libdir)/libIlmImfUtil.so
}
