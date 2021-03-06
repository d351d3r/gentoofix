EAPI=7
CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake-utils vcs-snapshot

DESCRIPTION="Advanced shading language for production GI renderers"
HOMEPAGE="http://opensource.imageworks.com/?p=osl"

MY_OSL="OpenShadingLanguage"
# SRC_URI="https://github.com/imageworks/${MY_OSL}/archive/Release-${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/imageworks/OpenShadingLanguage/archive/Release-${PV}-dev.tar.gz -> ${P}-dev.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

X86_CPU_FEATURES=(
	sse2:sse2 sse3:sse3 ssse3:ssse3 sse4_1:sse4.1 sse4_2:sse4.2
	avx:avx avx2:avx2 avx512f:avx512f f16c:f16c
)
CPU_FEATURES=( ${X86_CPU_FEATURES[@]/#/cpu_flags_x86_} )

IUSE="doc partio qt5 test ${CPU_FEATURES[@]%:*}"

RDEPEND="
	>=dev-libs/boost-1.62
	dev-libs/pugixml
	>=media-libs/openexr-2.2.0
	>=media-libs/openimageio-1.8.5
	sys-libs/zlib:=
	partio? ( media-libs/partio )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
"

DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/clang
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"

#PATCHES=(
#	"${FILESDIR}"/FindLLVM.cmake.patch
#	"${FILESDIR}/${PN}-1.10.6-fix-install-shaders.patch"
#	"${FILESDIR}"/llvm-10.patch
#)

# Restricting tests as Make file handles them differently
RESTRICT="test"

S="${WORKDIR}/${P}-dev"

src_configure() {
	append-cxxflags -std=c++14

	local cpufeature
	local mysimd=()
	for cpufeature in "${CPU_FEATURES[@]}"; do
		use "${cpufeature%:*}" && mysimd+=("${cpufeature#*:}")
	done

	# If no CPU SIMDs were used, completely disable them
	[[ -z ${mysimd} ]] && mysimd=("0")

	local gcc=$(tc-getCC)
	# LLVM needs CPP11. Do not disable.
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="share/doc/${PF}"
		-DINSTALL_DOCS=$(usex doc)
		-DLLVM_STATIC=OFF
		-DOSL_BUILD_TESTS=$(usex test)
		-DSTOP_ON_WARNING=OFF
		-DUSE_PARTIO=$(usex partio)
		-DUSE_QT=$(usex qt5)
		-DUSE_SIMD="$(IFS=","; echo "${mysimd[*]}")"
	)

	cmake-utils_src_configure
}
