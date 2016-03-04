lidar2dems:
	git clone https://github.com/Applied-GeoSolutions/lidar2dems.git
lidar2dems.installed: lidar2dems gippy.installed pdal.installed pcl.installed points2grid.installed laszip.installed cimg.installed numpy.installed scipy.installed
	cd lidar2dems && python setup.py install && touch ../$@
