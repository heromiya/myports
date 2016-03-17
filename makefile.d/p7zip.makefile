p7zip_ver = 15.14

p7zip_$(p7zip_ver)_src_all.tar.bz2: 
	wget http://jaist.dl.sourceforge.net/project/p7zip/p7zip/15.14/p7zip_15.14_src_all.tar.bz2
#	wget -q -nc http://sourceforge.net/projects/p7zip/files/p7zip/$(p7zip_ver)/$@
p7zip.installed: p7zip_$(p7zip_ver)_src_all.tar.bz2
	tar xaf $< && \
	cd p7zip_$(p7zip_ver)/CPP/7zip/CMAKE && \
	cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) . && \
	make && make install && touch ../$@

#	$(call compile)
#	sed -i "s#-DCMAKE_BUILD_TYPE=Debug#-DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR)#" ./generate.sh && \
#	dash ./generate.sh && \
#	cd CPP/7zip/P7ZIP.Unix && \
