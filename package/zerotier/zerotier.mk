################################################################################
#
# zerotier
#
################################################################################

ZEROTIER_VERSION = 1.2.10
ZEROTIER_SITE = https://github.com/zerotier/ZeroTierOne
ZEROTIER_SITE_METHOD = git
ZEROTIER_LICENSE = GPLv2
ZEROTIER_LICENSE_FILES = LICENSE.txt

define ZEROTIER_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define ZEROTIER_INSTALL_STAGING_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(STAGING_DIR) -C $(@D) install
endef

define ZEROTIER_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
