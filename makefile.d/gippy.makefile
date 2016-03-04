wheel.installed: pip.installed numpy.installed
	pip install wheel && touch $@
gippy.installed: pip.installed wheel.installed gdal.installed
	pip install gippy && touch $@
