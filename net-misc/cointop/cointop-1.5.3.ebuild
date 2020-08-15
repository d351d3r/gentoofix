EAPI=7

EGO_PN="github.com/miguelmota/${PN}"

inherit golang-vcs-snapshot

DESCRIPTION="A terminal based UI application for tracking cryptocurrencies"
HOMEPAGE="https://github.com/miguelmota/cointop"
SRC_URI="https://github.com/miguelmota/cointop/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror network-sandbox"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug pie"

DOCS=( README.md )
QA_PRESTRIPPED="usr/bin/.*"

G="${WORKDIR}/${P}"
S="${G}/src/${EGO_PN}"

src_compile() {
	export GOPATH="${G}"
	local mygoargs=(
		-v -work -x
		-buildmode "$(usex pie pie exe)"
		-asmflags "all=-trimpath=${S}"
		-gcflags "all=-trimpath=${S}"
		-ldflags "$(usex !debug '-s -w' '')"
		-o ./bin/cointop
	)
	go build "${mygoargs[@]}" || die
}

src_test() {
	go test -v ./... || die
}

src_install() {
	dobin bin/cointop
	use debug && dostrip -x /usr/bin/cointop
	einstalldocs
}
