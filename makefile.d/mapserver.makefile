mapserver-$(mapserver_ver).tar.gz:
	wget -q  http://download.osgeo.org/mapserver/mapserver-$(mapserver_ver).tar.gz
mapserver.installed: mapserver-$(mapserver_ver).tar.gz gdal.installed curl.installed expat.installed postgis.installed pcre.installed python.installed
	tar xaf $<
	mkdir -p mapserver-$(mapserver_ver)/build && \
	cd mapserver-$(mapserver_ver)/build && \
	cmake -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DWITH_CLIENT_WFS=ON \
	-DWITH_CLIENT_WMS=ON \
	-DWITH_CURL=ON \
	-DWITH_JAVA=OFF \
	-DWITH_GD=OFF \
	-DWITH_RSVG=0 \
	-DWITH_FRIBIDI=0 \
	-DWITH_FCGI=0 .. && \
	$(MAKE) && \
	$(MAKE) install && \
	touch ../../$@
