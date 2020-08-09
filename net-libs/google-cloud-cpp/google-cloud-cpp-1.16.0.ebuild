EAPI=7
inherit cmake-utils

JSON_VER="3.9.1"
#GOOGLECLOUDCOMMON_COMMIT="a4450d9552ab33a0a5135fd783abc6a808886b52"
#GOOGLEAPIS_COMMIT="19c4589a3cb44b3679f7b3fba88365b3d055d5f8"

DESCRIPTION="C++ Client Libraries for Google Cloud Platform APIs"
HOMEPAGE="https://github.com/googleapis/google-cloud-cpp"
SRC_URI="https://github.com/googleapis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="network-sandbox"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-libs/protobuf
	dev-libs/crc32c
	net-misc/curl[ssl]
	net-libs/grpc:=
	>=dev-cpp/nlohmann_json-${JSON_VER}"
#	net-libs/googleapis
#	=net-libs/google-cloud-cpp-common-${PV}

DEPEND="${RDEPEND}
	dev-cpp/gtest"

DOCS=( README.md )

#PATCHES=(
#	"${FILESDIR}/${PN}-0.17.0-openssl.patch"
#	"${FILESDIR}/${PN}-0.17.0-nlohmannjson.patch"
#	"${FILESDIR}/findre2.patch"
#)

#src_prepare() {
#	sed -i "s@re2 REQUIRED CONFIG@re2 REQUIRED@" cmake/re2.cmake || die
#}

src_configure() {
#	sed -i -e 's|"google/cloud/storage/internal/nlohmann_json.hpp"|<nlohmann/json.hpp>|g' google/cloud/storage/internal/{nljson.h,nljson_use_after_third_party_test.cc,nljson_use_third_party_test.cc} || die
#	sed -i -e "s|3_4_0|${JSON_VER//./_}|g" google/cloud/storage/internal/nljson.h || die

	local mycmakeargs=(
		-DgRPC_DEBUG=ON
		-Dprotobuf_DEBUG=ON
		-Dprotobuf_USE_STATIC_LIBS=OFF
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TESTING=OFF
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TESTING=OFF
	)

	cmake-utils_src_configure

}
