texinfo_ver = 5.2
texinfo-$(texinfo_ver).tar.xz:
	wget -q  http://ftp.gnu.org/gnu/texinfo/texinfo-$(texinfo_ver).tar.xz
texinfo.installed: texinfo-$(texinfo_ver).tar.xz
	$(call compile)
