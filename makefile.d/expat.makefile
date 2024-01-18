expat_ver = R_2_4_9
expat-$(expat_ver).tar.gz:
	wget -q -O $@ https://github.com/libexpat/libexpat/archive/refs/tags/$(expat_ver).tar.gz

#http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz

expat.installed: expat-$(expat_ver).tar.gz
	tar xaf $< && \
	cd libexpat-$(expat_ver)/expat && \
	$(call cmake,\
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DBUILD_shared=OFF) && touch ../../../$@

#	$(call compile,--enable-shared=yes)

