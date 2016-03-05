wheel.installed: pip.installed numpy.installed python.installed
	pip install wheel && touch $@
gippy.installed: pip.installed wheel.installed gdal.installed python.installed boost.installed
	pip install gippy && touch $@
