#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# Add OpenClash
rm -rf package/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git /tmp/OpenClash
mv /tmp/OpenClash/luci-app-openclash package/luci-app-openclash
rm -rf /tmp/OpenClash

# Bundle the Meta (mihomo) core into the firmware so it works offline
# without runtime download. MT7986 is arm64 (Cortex-A53).
echo "Fetching latest mihomo release tag..."
META_VER=$(curl -fsSL https://api.github.com/repos/MetaCubeX/mihomo/releases/latest \
    | grep -oE '"tag_name":\s*"[^"]+"' | head -n1 | cut -d'"' -f4)
if [ -z "$META_VER" ]; then
    echo "ERROR: failed to resolve latest mihomo version" >&2
    exit 1
fi
echo "Bundling mihomo $META_VER (linux-arm64)"
mkdir -p files/etc/openclash/core
curl -fL --retry 3 --retry-delay 2 \
    "https://github.com/MetaCubeX/mihomo/releases/download/${META_VER}/mihomo-linux-arm64-${META_VER}.gz" \
    -o /tmp/mihomo.gz
gunzip -c /tmp/mihomo.gz > files/etc/openclash/core/clash_meta
chmod +x files/etc/openclash/core/clash_meta
rm -f /tmp/mihomo.gz
ls -lh files/etc/openclash/core/clash_meta
