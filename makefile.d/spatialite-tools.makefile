spatialite-tools_ver = 4.3.0

spatialite-tools-$(spatialite-tools_ver).tar.gz: 
	wget -q  http://www.gaia-gis.it/gaia-sins/spatialite-tools-sources/spatialite-tools-$(spatialite-tools_ver).tar.gz
spatialite-tools.installed: spatialite-tools-$(spatialite-tools_ver).tar.gz libspatialite.installed freexl.installed readosm.installed
	$(call compile,\
	CC=gcc \
	CXX=g++ \
	CFLAGS="-fPIC -I$(INSTALL_DIR)/include -I$(INSTALL_DIR)/glibc-2.15/include -I$(INSTALL_DIR)/include/libxml2  -I$(INSTALL_DIR)/include/libxml " \
	CXXFLAGS="-fPIC -I$(INSTALL_DIR)/include -I$(INSTALL_DIR)/glibc-2.15/include -I$(INSTALL_DIR)/include/libxml2  -I$(INSTALL_DIR)/include/libxml " \
	PKG_CONFIG_PATH=$(shell pwd)/libspatialite-$(libspatialite_ver):$(shell pwd)/freexl-$(freexl_ver):$(shell pwd)/readosm-1.0.0b)


#	LIBS=" -static $(INSTALL_DIR)/lib/libspatialite.a $(INSTALL_DIR)/lib/libgeos_c.a $(INSTALL_DIR)/lib/libgeos.a $(INSTALL_DIR)/lib64/libstdc++.a $(INSTALL_DIR)/lib/libproj.a $(INSTALL_DIR)/glibc-2.15/lib/libm.a $(INSTALL_DIR)/lib/libsqlite3.a $(INSTALL_DIR)/lib/libxml2.a $(INSTALL_DIR)/lib/libz.a $(INSTALL_DIR)/lib/libfreexl.a $(INSTALL_DIR)/glibc-2.15/lib/libm.a $(INSTALL_DIR)/lib/libgeos_c.a $(INSTALL_DIR)/lib/liblzma.a $(INSTALL_DIR)/glibc-2.15/lib/libpthread.a $(INSTALL_DIR)/glibc-2.15/lib/libdl.a $(INSTALL_DIR)/glibc-2.15/lib/libc.a " \

#	LIBS="-static -lsqlite3 -lm -lc" \
#	LDFLAGS=" $(LDFLAGS) -L$(INSTALL_DIR)/glibc-2.15/lib" \


#	LIBS="-lgeos -lgeos_c -lspatialite -lxml2  -ldl -lsqlite3 -lm -ldl" \
#	LIBS=" -static $(INSTALL_DIR)/glibc-2.15/lib/libm.a $(INSTALL_DIR)/glibc-2.15/lib/libc.a $(INSTALL_DIR)/glibc-2.15/lib/libdl.a -pthread" \
# 
