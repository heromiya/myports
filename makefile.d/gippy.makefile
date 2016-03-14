wheel-0.29.0.tar.gz:
	wget https://pypi.python.org/packages/source/w/wheel/$@

wheel.installed: wheel-0.29.0.tar.gz pip.installed numpy.installed python.installed
	tar xaf $< && cd setuptools-20.2.2 && ./setup.py install && touch ../$@
#	pip install wheel && touch $@

gippy-0.3.5.tar.gz:
	wget https://pypi.python.org/packages/source/g/gippy/$@

gippy.installed: gippy-0.3.5.tar.gz pip.installed wheel.installed gdal.installed python.installed boost.installed
	tar xaf $< && cd setuptools-20.2.2 && ./setup.py install && touch ../$@
#	pip install gippy && touch $@

# swig is needed
