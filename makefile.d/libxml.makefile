libxml2_ver = 2.9.1
libxml2-$(libxml2_ver).tar.gz:
	wget http://xmlsoft.org/sources/libxml2-$(libxml2_ver).tar.gz
libxml2.installed: libxml2-$(libxml2_ver).tar.gz python.installed
	$(call compile,CFLAGS="$(CFLAGS) -shared")
