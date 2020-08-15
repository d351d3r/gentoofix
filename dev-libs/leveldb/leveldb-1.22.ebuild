EAPI=7

inherit cmake toolchain-funcs

DESCRIPTION="A fast and lightweight key-value database library"
HOMEPAGE="http://leveldb.org/ https://github.com/google/leveldb"
SRC_URI="https://github.com/google/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"
IUSE="+crc32c +snappy +tcmalloc debug test"
RESTRICT="!test? ( test )"

DEPEND="tcmalloc? ( dev-util/google-perftools )
	snappy? ( app-arch/snappy )
	crc32c? ( dev-libs/crc32c )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/0001-Restore-soname-versioning-with-CMake-build.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex debug "Debug" "Release")
		-DBUILD_SHARED_LIBS=1 \
		-DLEVELDB_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_test() {
	emake check
}

src_install() {
	cmake_src_install

	insinto /usr/include/leveldb/helpers
	doins helpers/memenv/memenv.h
}