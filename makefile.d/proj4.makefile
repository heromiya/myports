proj.4:
	git clone https://github.com/OSGeo/proj.4.git
proj4.installed: proj.4 cmake.installed
	cd $< && $(call cmake,-DBUILD_LIBPROJ_SHARED=OFF -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR))
