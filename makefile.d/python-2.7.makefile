python_ver = 2.7.11
Python-$(python_ver).tar.xz:
	wget -q  --no-check-certificate http://www.python.org/ftp/python/$(python_ver)/Python-$(python_ver).tar.xz
python.installed: Python-$(python_ver).tar.xz curl.installed openssl.installed
	$(call compile,--enable-shared LDFLAGS="-L$(INSTALL_DIR)/lib -L/usr/lib" LIBS="-lcurl")
