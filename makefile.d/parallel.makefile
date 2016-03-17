parallel_ver = 20160222

parallel-$(parallel_ver).tar.bz2:
	wget -q  http://ftp.gnu.org/gnu/parallel/parallel-$(parallel_ver).tar.bz2

parallel.installed: parallel-$(parallel_ver).tar.bz2 perl.installed
	$(call compile)
