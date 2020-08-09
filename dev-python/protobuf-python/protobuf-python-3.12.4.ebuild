EAPI="7"
PYTHON_COMPAT=(python3_{7..9})
DISTUTILS_USE_SETUPTOOLS="manual"

inherit distutils-r1

DESCRIPTION="Google's Protocol Buffers - Python bindings"
HOMEPAGE="https://developers.google.com/protocol-buffers/ https://github.com/protocolbuffers/protobuf"
SRC_URI="https://github.com/protocolbuffers/protobuf/archive/v${PV}.tar.gz -> protobuf-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0/23"
KEYWORDS="amd64 arm64"
IUSE=""

BDEPEND="${PYTHON_DEPS}
	~dev-libs/protobuf-${PV}
	dev-python/namespace-google[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${PYTHON_DEPS}
	~dev-libs/protobuf-${PV}"
RDEPEND="${BDEPEND}
	!<dev-libs/protobuf-3[python(-)]"

S="${WORKDIR}/protobuf-${PV}/python"

python_configure_all() {
	mydistutilsargs=(--cpp_implementation)
}

python_compile() {
	python_is_python3 || local -x CXXFLAGS="${CXXFLAGS} -fno-strict-aliasing"
	distutils-r1_python_compile
}

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all

	find "${D}" -name "*.pth" -type f -delete || die
}
