python_ver = 2.7.9
Python-$(python_ver).tar.xz:
	wget --no-check-certificate http://www.python.org/ftp/python/$(python_ver)/Python-$(python_ver).tar.xz
python.installed: Python-$(python_ver).tar.xz curl.installed
	$(call compile,--enable-shared LIBS="-lssl -lcurl")
