include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-deepseek
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=DeepSeek Configuration Interface
LUCI_DEPENDS:=+luci-base +luci-compat
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/install
    # 安装LuCI组件
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci
    cp -pR ./luasrc/* $(1)/usr/lib/lua/luci/
    
    # 安装配置文件
    $(INSTALL_DIR) $(1)/etc/config
    $(INSTALL_CONF) ./root/etc/config/deepseek $(1)/etc/config/
    
    # 安装启动脚本
    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) ./root/etc/init.d/deepseek $(1)/etc/init.d/
    
    # 安装执行脚本
    $(INSTALL_DIR) $(1)/usr/libexec/
    $(INSTALL_BIN) ./root/usr/libexec/rpc-deepseek $(1)/usr/libexec/
    
    # 安装多语言文件
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
    $(INSTALL_DATA) ./po/zh_Hans/deepseek.po $(1)/usr/lib/lua/luci/i18n/deepseek.zh_Hans.po
endef

# 包含多语言支持
$(eval $(call BuildPackage,$(PKG_NAME)))
