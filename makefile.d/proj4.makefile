proj_ver=9.2.1
proj-$(proj_ver).tar.gz:
	wget -q http://download.osgeo.org/proj/$@

proj4.installed: proj-$(proj_ver).tar.gz 
	tar xaf $< && cd $(basename $(basename $<)) && $(call cmake,\
    -DTIFF_INCLUDE_DIR=$(INSTALL_DIR)/include \
    -DTIFF_LIBRARY_RELEASE=$(INSTALL_DIR)/lib/libtiff.so \
    -DENABLE_TIFF=OFF \
    -DENABLE_CURL=OFF \
    -DBUILD_PROJSYNC=OFF \
    )
