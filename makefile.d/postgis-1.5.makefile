postgis_ver = 1.5.8
postgis-$(postgis_ver).tar.gz:
	wget -q  http://download.osgeo.org/postgis/source/postgis-$(postgis_ver).tar.gz
postgis-1.5.installed: postgis-$(postgis_ver).tar.gz postgresql-8.4.installed proj4.installed geos.installed
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=gcc && \
	export CXX=g++ && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	./configure --prefix=$(INSTALL_DIR)/postgresql-8.4 \
	--enable-thread-safety \
	--without-readline \
	--with-projdir=$(INSTALL_DIR) && \
	$(MAKE) && \
	$(MAKE) install && \
	cd .. && touch $@


