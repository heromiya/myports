setuptools-20.2.2.tar.gz: python.installed
	wget -q https://pypi.python.org/packages/source/s/setuptools/$@
setuptools.installed: setuptools-20.2.2.tar.gz
	tar xaf $< && cd setuptools-20.2.2 && ./setup.py install && touch ../$@

pip.installed: setuptools.installed
	easy_install pip && touch $@
