EAPI=7

inherit autotools eutils

MY_PN=secp256k1

DESCRIPTION="Optimized C library for EC operations on curve secp256k1"
HOMEPAGE="https://github.com/bitcoin-core/secp256k1"
COMMITHASH="979961c506c423034a35e62c5937c837bc179358"
SRC_URI="https://github.com/bitcoin-core/${MY_PN}/archive/${COMMITHASH}.tar.gz -> ${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="+asm ecdh endomorphism experimental gmp java +recovery test test_openssl"

REQUIRED_USE="
	ecdh? ( experimental )
	java? ( ecdh )
	test_openssl? ( test )
"
RDEPEND="
	gmp? ( dev-libs/gmp:0= )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	java? ( virtual/jdk )
	test_openssl? ( dev-libs/openssl:0 )
"

S="${WORKDIR}/${MY_PN}-${COMMITHASH}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local asm_opt
	if use asm; then
		asm_opt=auto
	else
		asm_opt=no
	fi
	econf \
		--disable-benchmark \
		$(use_enable experimental) \
		$(use_enable java jni) \
		$(use_enable test tests) \
		$(use_enable test_openssl openssl-tests) \
		$(use_enable ecdh module-ecdh) \
		$(use_enable endomorphism)  \
		--with-asm=$asm_opt \
		--with-bignum=$(usex gmp gmp no) \
		$(use_enable recovery module-recovery) \
		--disable-static
}

src_install() {
	dodoc README.md
	emake DESTDIR="${D}" install
	find "${D}" -name '*.la' -delete || die
}
