EAPI=7
PYTHON_COMPAT=(python3_{7..9})
inherit distutils-r1 python-utils-r1

DESCRIPTION="Deep Learning for humans"
HOMEPAGE="http://keras.io/"
LICENSE="MIT"
KEYWORDS="amd64"

SRC_URI="https://github.com/keras-team/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"

IUSE="+python cudnn hdf5 hdf5 h5py graphviz"

RESTRICT="mirror"
RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.19.0
	>=sci-libs/scipy-0.19.1
	>=dev-python/pyyaml-3.12
	>=dev-python/six-1.10.0"
DEPEND="${RDEPEND}
		python? ( dev-lang/python )
		cudnn? ( dev-libs/cudnn )
		hdf5? ( sci-libs/hdf5 )
		h5py? ( dev-python/h5py )
		graphviz? ( dev-python/graphviz )"

pkg_postinst(){
	ewarn "To run keras you need one of the supported backends: TensorFlow, CNTK, or Theano."
	ewarn "At least sci-libs/tensorflow is part of the main tree."
}
