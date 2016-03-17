expat_ver = 2.1.0
expat-$(expat_ver).tar.gz:
	wget -q  http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz
<<<<<<< HEAD
expat.installed: expat-$(expat_ver).tar.gz
	tar xaf $< && cd expat-$(expat_ver) && $(call cmake,-DBUILD_shared=ON)

=======
expat.installed: expat-$(expat_ver).tar.gz cmake.installed
	tar xaf $< && \
	cd expat-$(expat_ver) && \
	$(call cmake,\
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DBUILD_shared=ON)
>>>>>>> e0403da8baba649de941693ee7bfefd06add751d
#	$(call compile,--enable-shared)
