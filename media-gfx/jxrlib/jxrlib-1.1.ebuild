EAPI=6
inherit cmake-utils multilib

DESCRIPTION="Оpen source implementation of the jpegxr image format standard"
HOMEPAGE="https://jxrlib.codeplex.com/"
SRC_URI="http://cdn.debian.net/debian/pool/main/j/${PN}/${PN}_${PV}.orig.tar.gz -> ${P}.tar.gz"

# LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64"
# IUSE="doc static-libs test"

# RDEPEND="media-libs/lcms:2=[static-libs?]
#	media-libs/libpng:0=[static-libs?]
#	media-libs/tiff:0=[static-libs?]
#	sys-libs/zlib:=[static-libs?]"
#DEPEND="${RDEPEND}
#	doc? ( app-doc/doxygen )"

# DOCS=( AUTHORS CHANGES NEWS README THANKS )

# RESTRICT="test" #409263

#S="${WORKDIR}/${P}"

PATCHES=(
	"${FILESDIR}"/usecmake.patch
	"${FILESDIR}"/bug748590.patch
	"${FILESDIR}"/typos.patch
)

#src_prepare() {
# 	# Stop installing LICENSE file, and install CHANGES from DOCS instead:
# 	sed -i -e '/install.*FILES.*DESTINATION.*OPENJPEG_INSTALL_DOC_DIR/d' CMakeLists.txt || die
#}

#src_configure() {
# Purposely not set CMAKE_BUILD_TYPE, see #701231
#	cp 
#	local mycmakeargs=(
#		-DCMAKE_BUILD_TYPE:STRING=NONE \
#		-DJXRLIB_INSTALL_LIB_DIR="${get_libdir}lib/"
#	)
#		$(cmake-utils_use_build doc)
#		$(cmake-utils_use_build test TESTING)

#CMAKE_EXTRA_FLAGS += -DCMAKE_BUILD_TYPE:STRING=NONE \
# -DJXRLIB_INSTALL_LIB_DIR="${get_libdir}lib/"

#	cmake-utils_src_configure
#}

#src_compile() {
#	cmake-utils_src_compile

#	if use static-libs ; then
#		BUILD_DIR=${BUILD_DIR}_static cmake-utils_src_compile
#	fi
#}

#src_install() {
#	if use static-libs ; then
#		BUILD_DIR=${BUILD_DIR}_static cmake-utils_src_install
#		#static bins overwritten by shared install
#	fi

#	cmake-utils_src_install
#}
