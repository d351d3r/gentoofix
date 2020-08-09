EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1 multiprocessing

DESCRIPTION="Protobuf code generator for gRPC"
HOMEPAGE="https://grpc.io"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	~dev-python/grpcio-${PV}[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/setup.py-respect-cc.patch" )

python_configure_all() {
	export GRPC_PYTHON_BUILD_WITH_CYTHON=1
	export GRPC_PYTHON_BUILD_EXT_COMPILER_JOBS="$(makeopts_jobs)"
}
