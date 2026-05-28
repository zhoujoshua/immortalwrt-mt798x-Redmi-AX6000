#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# Passwall feed removed: upstream xiaorouji/openwrt-passwall was deleted
# (the project was split into luci-app-passwall + openwrt-passwall-packages).
# Re-enable below if you actually need passwall; OpenClash (loaded via
# diy-part2.sh) is the proxy app this build relies on.
#echo 'src-git passwall_luci https://github.com/xiaorouji/luci-app-passwall;main' >>feeds.conf.default
#echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages;main' >>feeds.conf.default
