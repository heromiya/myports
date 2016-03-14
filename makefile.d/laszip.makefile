#LASzip:
#	git clone https://github.com/LASzip/LASzip.git
#laszip.installed: LASzip
#	cd $< && $(call cmake,-DLASZIP_BUILD_STATIC=ON)

laszip-src-2.2.0.tar.gz:
	wget -q  https://github.com/LASzip/LASzip/releases/download/v2.2.0/laszip-src-2.2.0.tar.gz
laszip.installed: laszip-src-2.2.0.tar.gz
	$(call compile)
#	tar xaf $< && cd laszip-src-2.2.0 && ./configure --prefix=$(INSTALL_DIR) && make && make install && cd .. && touch $@
