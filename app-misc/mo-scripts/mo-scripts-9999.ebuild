# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Personal scripts for backups, pictures, PDFs, screenshots and brightness"
HOMEPAGE="https://github.com/Massimo-B/scripts"
EGIT_REPO_URI="https://github.com/Massimo-B/scripts.git"

# Upstream does not currently declare a license.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS=""

RDEPEND="
	app-backup/dar
	app-misc/ddcutil
	app-shells/bash
	app-text/ghostscript-gpl
	app-text/pdftk
	app-text/qpdf
	media-gfx/flameshot
	media-gfx/imagemagick[jpeg]
	sys-apps/coreutils
	sys-apps/file
	sys-apps/gawk
	sys-apps/grep
	sys-apps/sed
	sys-apps/util-linux
	sys-devel/bc
	sys-libs/ncurses
	x11-misc/xdotool
"

PATCHES=( "${FILESDIR}/${PN}-system-libraries.patch" )

src_prepare() {
	default

	# Keep architecture-independent shell libraries out of /usr/local and PATH.
	sed -i \
		-e 's|${BASH_PREFIX:-/}usr/local/lib|@LIBDIR@|g' \
		-e "s|@LIBDIR@|${EPREFIX}/usr/share/${PN}|g" \
		compress_pictures dar_wrapper shrinkpdf lib_output || die
}

src_install() {
	local script
	for script in *; do
		[[ -f ${script} && -x ${script} ]] || continue
		newbin "${script}" "mo-${script}"
	done

	insinto "/usr/share/${PN}"
	doins lib_colors lib_output
	dodoc README.md
}
