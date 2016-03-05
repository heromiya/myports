expat-$(expat_ver).tar.gz:
	wget -q  http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz
expat.installed: expat-$(expat_ver).tar.gz
	$(call compile,--enable-shared)
