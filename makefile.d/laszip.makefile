LASzip:
	git clone https://github.com/LASzip/LASzip.git
laszip.installed: LASzip
	cd $< && $(cmake)
