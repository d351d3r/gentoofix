EAPI=6
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Python extension to the AstroDienst Swiss Ephemeris"
HOMEPAGE="https://github.com/astrorigin/pyswisseph"
COMMIT_ID=9783fecbc7b6247391908c42d373935aa1a56b90
SRC_URI="https://github.com/astrorigin/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"
S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="GPL-2+"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
