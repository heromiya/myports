geos_ver = 3.4.2

geos-$(geos_ver).tar.bz2:
	wget -q  http://download.osgeo.org/geos/geos-$(geos_ver).tar.bz2
geos.installed: geos-$(geos_ver).tar.bz2 proj4.installed python.installed
	$(call compile,--enable-python)
