EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=bdepend
inherit cmake-utils distutils-r1

DESCRIPTION="Lightweight library that exposes C++ types in Python and vice versa"
HOMEPAGE="https://pybind11.readthedocs.org/"
SRC_URI="https://github.com/pybind/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc man info test"

RDEPEND="info? ( sys-apps/texinfo )"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/breathe[${PYTHON_USEDEP}]
	)
	man? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/breathe[${PYTHON_USEDEP}]
	)
	info? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/breathe[${PYTHON_USEDEP}]
	)"

src_prepare() {
	cmake-utils_src_prepare
}


src_configure() {
	local mycmakeargs=(
		-DPYBIND11_INSTALL=ON
		-DPYBIND11_TEST=$(usex test)
	)
	cmake-utils_src_configure
}

src_compile() {
	distutils-r1_src_compile

	cmake-utils_src_compile

	if use doc || use man || use info; then
		cd docs || die
		emake $(use doc && echo html) $(use man && echo man) $(use info && echo info)
	fi
}

src_install() {
	distutils-r1_src_install

	cmake-utils_src_install

	dodoc README.md
	use doc && dodoc -r docs/.build/html
	use man && doman docs/.build/man/pybind11.1
	use info && doinfo docs/.build/texinfo/pybind11.info

#	rm -rf "${ED%/}"/usr/include/python*
}
