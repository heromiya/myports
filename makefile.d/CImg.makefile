CImg_1.6.9.zip:
	wget -q  http://cimg.eu/files/$@

cimg.installed: CImg_1.6.9.zip
	unzip -o $< && cd CImg-1.6.9 && cp CImg.h $(INSTALL_DIR)/include && cd .. && touch $@
