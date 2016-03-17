libssh2-1.7.0.tar.gz:
	wget -q -nc https://www.libssh2.org/download/$@

libssh2.installed: libssh2-1.7.0.tar.gz
	$(call cmake)
