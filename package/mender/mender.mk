################################################################################
#
# mender
#
################################################################################

MENDER_VERSION = 1.4.0
MENDER_SOURCE = mender-$(MENDER_VERSION).tar.gz
MENDER_SITE = $(call github,mendersoftware,mender,$(MENDER_VERSION))

define MENDER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 package/mender/mender.conf \
		$(TARGET_DIR)/etc/mender/mender.conf
	$(INSTALL) -D -m 0644 package/mender/tenant.conf \
		$(TARGET_DIR)/etc/mender/tenant.conf
	$(INSTALL) -D -m 0644 package/mender/server.crt \
		$(TARGET_DIR)/etc/mender/server.crt
	$(INSTALL) -D -m 0755 package/mender/mender-device-identity \
		$(TARGET_DIR)/var/share/mender/identity/mender-device-identity
	$(INSTALL) -D -m 0755 package/mender/mender-inventory-network \
		$(TARGET_DIR)/var/share/mender/inventory/mender-inventory-network
	$(INSTALL) -D -m 0755 package/mender/mender-inventory-hostinfo \
		$(TARGET_DIR)/var/share/mender/inventory/mender-inventory-hostinfo
	$(INSTALL) -D -m 0755 $(@D)/bin/mender \
		$(TARGET_DIR)/usr/bin/mender
endef

define MENDER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 package/mender/mender.service \
		$(TARGET_DIR)/usr/lib/systemd/system/mender.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -fs ../../../../usr/lib/systemd/system/mender.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/mender.service
endef

define MENDER_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/mender/S99mender \
		$(TARGET_DIR)/etc/init.d/S99mender
endef


$(eval $(golang-package))
