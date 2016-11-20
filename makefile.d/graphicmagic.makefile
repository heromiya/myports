graphicmagick_ver = 1.3.21

GraphicsMagick-$(graphicmagick_ver).tar.bz2:
	wget -q  http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/$(graphicmagick_ver)/GraphicsMagick-$(graphicmagick_ver).tar.bz2
graphicmagick.installed lib/libGraphicsMagick.so: GraphicsMagick-$(graphicmagick_ver).tar.bz2
	$(call compile,--enable-shared --with-quantum-depth=16 --disable-static --with-magick-plus-plus=yes)
