setuptools-20.2.2.tar.gz: python.installed
	wget -q --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/$@
bin/easy_install: setuptools-20.2.2.tar.gz
	tar xaf $< && cd setuptools-20.2.2 && ./setup.py install

pip.installed: bin/easy_install
	easy_install pip && touch $@
