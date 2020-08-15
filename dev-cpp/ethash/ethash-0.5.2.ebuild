EAPI=7

inherit eutils cmake

DESCRIPTION="C/C++ implementation of Ethash – the Ethereum Proof of Work algorithm"
HOMEPAGE="https://github.com/chfast/ethash"
SRC_URI="https://github.com/chfast/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="debug test"

RDEPEND=""
DEPEND="${RDEPEND}"

CMAKE_MIN_VERSION="3.5"

src_prepare() {
	rm cmake/cable/HunterGate.cmake || die

	sed -r -i \
		-e 's/include(\(HunterGate\))/function\1\nendfunction\(\)/' \
		CMakeLists.txt || die

	sed -r -i \
		-e 's/^[[:space:]]*ethash$/\0 SHARED/' \
		lib/ethash/CMakeLists.txt || die

	sed -r -i \
		-e '/hunter_add_package/d' \
		test/benchmarks/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex debug "Debug" "Release")
		-DETHASH_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
