postgis_ver = 2.1.8
postgis-$(postgis_ver).tar.gz:
	wget -q  http://download.osgeo.org/postgis/source/$@
postgis-2.1.installed: postgis-$(postgis_ver).tar.gz postgresql.installed proj4.installed geos.installed
	$(call compile, --with-projdir=$(INSTALL_DIR) CFLAGS="$(CFLAGS) -pthread")
