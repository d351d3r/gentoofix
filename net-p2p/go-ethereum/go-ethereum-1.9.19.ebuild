EAPI=7

inherit golang-base

DESCRIPTION="Official golang implementation of the Ethereum protocol"
HOMEPAGE="https://github.com/ethereum/go-ethereum"
SRC_URI="https://github.com/ethereum/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="amd64"
IUSE="devtools"

DEPEND="
	dev-lang/go:=
"
RDEPEND="${DEPEND}"

RESTRICT="test strip network-sandbox"

src_compile() {
	emake $(usex devtools all geth)
}

src_install() {
	einstalldocs

	dobin build/bin/geth
	if use devtools; then
		mv build/bin/ethkey build/bin/geth-ethkey
		for F in build/bin/*; do
			if [[ "${F}" == "build/bin/examples" ]]; then
				continue
			fi
			dobin "${F}"
		done
	fi
}
