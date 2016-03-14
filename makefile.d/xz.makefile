xz_ver = 5.2.2

xz-$(xz_ver).tar.bz2:
	wget -q  http://tukaani.org/xz/$@
xz.installed: xz-$(xz_ver).tar.bz2
	$(call compile)
