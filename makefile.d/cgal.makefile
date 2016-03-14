CGAL-4.7.tar.xz:
	wget -q  https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.7/$@
cgal.installed: CGAL-4.7.tar.xz
	tar xaf $< && cd CGAL-4.7 && $(cmake)
