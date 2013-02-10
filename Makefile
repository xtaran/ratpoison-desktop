all: metapackages-deb desktop-deb

metapackages-deb:
	if [ -d abe-metapackages ]; then cd abe-metapackages; debuild -uc -us; fi

desktop-deb:
	cd abe-desktop; debuild -uc -us; fi

clean:
	debclean --cleandebs
	rm -f *.dsc *.tar.gz *~
