# mo-overlay

Personal Gentoo overlay for custom ebuilds.

## Ebuilds

| Package | Versions | Description |
| --- | --- | --- |
| [`app-misc/mo-scripts`](app-misc/mo-scripts/) | `9999` | [Shell utilities](https://github.com/Massimo-B/scripts) for display brightness, screenshots, picture management, PDF compression, and backups. |
| [`sys-apps/etckeeper`](sys-apps/etckeeper/) | `1.18.23`, `9999` | [Tools to version-control `/etc`](https://github.com/Massimo-B/etckeeper), preserving file metadata and automatically committing changes during package upgrades. |

## Installation

Add and sync the overlay as root:

```sh
emerge --ask app-eselect/eselect-repository dev-vcs/git
eselect repository add mo-overlay git https://github.com/Massimo-B/gentoo-overlay.git
emaint sync -r mo-overlay
```

Add the desired entries to `/etc/portage/package.accept_keywords` (or a file inside that directory). Replace `~amd64` with your architecture's testing keyword:

```text
=app-misc/mo-scripts-9999::mo-overlay **
=sys-apps/etckeeper-1.18.23::mo-overlay ~amd64
```

Emerge the desired package as root:

```sh
emerge --ask app-misc/mo-scripts::mo-overlay
emerge --ask =sys-apps/etckeeper-1.18.23::mo-overlay
```

For live etckeeper, use `9999` instead of `1.18.23` and accept `**` instead of `~amd64`.
