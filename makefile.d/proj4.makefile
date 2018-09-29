proj_ver=5.1.0
proj-$(proj_ver).tar.gz:
	wget -q http://download.osgeo.org/proj/$@
#	git clone https://github.com/OSGeo/proj.4.git
proj4.installed: proj-$(proj_ver).tar.gz
	$(call compile,--enable-shared=yes)
