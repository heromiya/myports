geos_ver = 3.4.2

geos-$(geos_ver).tar.bz2:
	wget -q  http://download.osgeo.org/geos/geos-$(geos_ver).tar.bz2
geos.installed: geos-$(geos_ver).tar.bz2 proj4.installed python.installed
	tar xaf $< && cd geos-$(geos_ver) && $(call cmake,-DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++) && touch ../../$@
#	$(call compile,--enable-python)
