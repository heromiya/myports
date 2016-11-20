numpy_version = 1.10.4

numpy-$(numpy_version).tar.gz:
	wget --no-check-certificate -q http://sourceforge.net/projects/numpy/files/NumPy/$(numpy_version)/$@
numpy.installed: numpy-$(numpy_version).tar.gz
	tar xaf $<
	cd numpy-$(numpy_version) && python setup.py build install --prefix $(INSTALL_DIR) && cd .. && touch $@
