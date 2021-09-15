flex-$(flex_ver).tar.xz:
	wget $(wget_opt) http://sourceforge.net/projects/flex/files/flex-$(flex_ver).tar.xz
flex.installed: flex-$(flex_ver).tar.xz
	$(call compile)
