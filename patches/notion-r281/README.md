# Notion R281 device support patches

These patches add ramips/mt7621 support for the Notion R281 and are applied
by the workflow directly on top of an unmodified tag from the official
`openwrt/openwrt` repository (see `SOURCE_URL` / `SOURCE_TAG` in
`.github/workflows/build-openwrt.yaml`). They replace the previous approach
of maintaining a separate `openwrt-24.10.x` branch on a personal fork for
every point release.

Apply order (also encoded in the filenames, applied via `git am`):

1. `0001-Update-platform.sh.patch` — sysupgrade platform check
2. `0002-Update-02_network.patch` — network board detection
3. `0003-Update-01_leds.patch` — LED board detection
4. `0004-Update-mt7621.mk.patch` — image build definition
5. `0005-Create-mt7621_notion_r281.dts.patch` — device tree
6. `0006-Update-ramips.patch` — uboot-envtools entry
7. `0007-Update-mt7621_notion_r281.dts.patch` — device tree fix-up

## Updating for a new OpenWrt release

Point releases (24.10.x) very rarely touch these files, so in most cases
the existing patches will apply unchanged — just bump the `version` input
in the workflow (e.g. `24.10.9`) and run a build.

If `git am` fails during the "Apply Notion R281 Device Support Patches"
step (e.g. after a minor/major version bump that touched the same files),
regenerate the series against the new tag:

```bash
git clone --branch v<NEW_VERSION> --single-branch https://github.com/openwrt/openwrt.git openwrt
cd openwrt
git checkout -b build-<NEW_VERSION>
git am ../patches/notion-r281/*.patch   # fix any conflicts, then:
git format-patch --no-signature --zero-commit -o ../patches/notion-r281 v<NEW_VERSION>..build-<NEW_VERSION>
```

Commit the refreshed `.patch` files in place of the old ones.

## Why this instead of a fork branch per release

- No need to create/maintain a new branch (and keep it in sync with
  upstream) for every OpenWrt point release.
- The workflow always builds from an unmodified, verifiable upstream tag,
  so the resulting `vermagic`/kmod ABI matches the official
  `downloads.openwrt.org/releases/<version>/...` kmod packages exactly.
- Device support changes live as reviewable patch files inside this repo,
  next to the workflow that consumes them.
