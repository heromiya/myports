postgis_ver = 1.5.8
postgis-$(postgis_ver).tar.gz:
	wget -q  http://download.osgeo.org/postgis/source/postgis-$(postgis_ver).tar.gz
postgis-1.5.installed: postgis-$(postgis_ver).tar.gz postgresql-8.4.installed proj4.installed geos.installed
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=gcc && \
	export CXX=g++ && \
	export CFLAGS="-I$(INSTALL_DIR)/postgresql-8.4/include -I./liblwgeom -lpthread -ldl " && \
	export CXXFLAGS="-I$(INSTALL_DIR)/postgresql-8.4/include -I./liblwgeom -lpthread -ldl " && \
	export LDFLAGS="-L$(INSTALL_DIR)/postgresql-8.4/lib" && \
	./configure --prefix=$(INSTALL_DIR)/postgresql-8.4 \
	--without-readline \
	--with-pgconfig=$(INSTALL_DIR)/postgresql-8.4/bin/pg_config \
	--with-geosconfig=$(INSTALL_DIR)/bin/geos-config && \
	sed -i 's#include "liblwgeom.h"#include "../liblwgeom/liblwgeom.h"#g' postgis/* && \
	$(MAKE) && \
	$(MAKE) install && \
	cd .. && touch $@

#	--with-xml2config=/usr/bin/xml2-config \
#	--with-geosconfig=$(INSTALL_DIR)/bin/geos-config \
#	--with-projdir=$(INSTALL_DIR) && \
#	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
#	sed -i 's#include "liblwgeom.h"#include "../liblwgeom/liblwgeom.h"#g' postgis/lwgeom_accum.c && \
#	sed -i 's#include "liblwgeom.h"#include "../liblwgeom/liblwgeom.h"#g' postgis/lwgeom_ogc.c && \

#	#	export CPPFLAGS="$(CFLAGS)" && \
#	export FFLAGS="$(CFLAGS)" && \
