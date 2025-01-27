include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-deepseek
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=DeepSeek Configuration Interface
  DEPENDS:=+luci-base +luci-compat
  PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
  LuCI interface for configuring DeepSeek services.
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

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
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
