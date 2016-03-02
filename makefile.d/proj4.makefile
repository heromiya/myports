proj.4:
	git clone https://github.com/OSGeo/proj.4.git
proj4.installed: proj.4
	cd $< && $(cmake)
