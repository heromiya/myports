expat-$(expat_ver).tar.gz:
	wget -q  http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz
expat.installed: expat-$(expat_ver).tar.gz cmake.installed
	tar xaf $< && cd expat-$(expat_ver) && $(call cmake,-DBUILD_shared=ON)
#	$(call compile,--enable-shared)
