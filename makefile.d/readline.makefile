readline_ver = 6.3

readline-$(readline_ver).tar.gz:
	wget -q https://ftp.gnu.org/gnu/readline/$@
readline.installed: readline-$(readline_ver).tar.gz lib/libncurses.a
	$(call compile,--disable-shared)
