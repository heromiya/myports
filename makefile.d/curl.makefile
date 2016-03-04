curl_ver = 7.41.0
curl-$(curl_ver).tar.lzma:
	wget http://www.execve.net/curl/$@
curl.installed: curl-$(curl_ver).tar.lzma xz.installed
	$(call compile)
