pcre2-$(pcre_ver).tar.bz2:
	wget -q https://github.com/PCRE2Project/pcre2/releases/download/pcre2-$(pcre_ver)/$@ 
pcre.installed: pcre2-$(pcre_ver).tar.bz2
	$(call compile)
