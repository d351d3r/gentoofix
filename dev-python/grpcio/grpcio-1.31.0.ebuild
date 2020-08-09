EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1 multiprocessing

DESCRIPTION="High-performance RPC framework (python libraries)"
HOMEPAGE="https://grpc.io"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 arm64"

RDEPEND=">=dev-libs/openssl-1.0.2:0=[-bindist]
	>=dev-python/cython-0.28.3[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	net-dns/c-ares:=
	sys-libs/zlib:=
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/setup.py-respect-cc.patch" )

python_configure_all() {
	export GRPC_PYTHON_DISABLE_LIBC_COMPATIBILITY=1
	export GRPC_PYTHON_BUILD_SYSTEM_CARES=1
	export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
	export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
	export GRPC_PYTHON_BUILD_WITH_CYTHON=1
	export GRPC_PYTHON_BUILD_EXT_COMPILER_JOBS="$(makeopts_jobs)"
}
