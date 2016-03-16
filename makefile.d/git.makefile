git-2.7.3.tar.gz:
	wget -q https://www.kernel.org/pub/software/scm/git/$@

git.installed: git-2.7.3.tar.gz
	$(call compile) && touch ../$@
