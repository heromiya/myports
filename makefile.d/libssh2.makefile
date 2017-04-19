libssh2_ver = 1.8.0
libssh2-$(libssh2_ver).tar.gz:
	wget -q -nc https://www.libssh2.org/download/$@

libssh2.installed: libssh2-$(libssh2_ver).tar.gz
	$(call compile,--without-libgcrypt)
#	tar xaf $< && cd $(basename $(basename $<)) && $(call cmake)
