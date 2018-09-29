
Python-$(python_ver).tar.xz:
	wget -nc -q  --no-check-certificate http://www.python.org/ftp/python/$(python_ver)/Python-$(python_ver).tar.xz

python.installed: Python-$(python_ver).tar.xz curl.installed openssl.installed expat.installed
	$(call compile,\
	--enable-shared \
	--enable-unicode \
	--without-ensurepip \
	--with-system-expat \
	LDFLAGS="-L$(INSTALL_DIR)/lib -L/usr/lib" \
	LIBS="-lcurl")

