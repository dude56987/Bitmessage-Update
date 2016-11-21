show:
	echo 'Run "make install" as root to install program!'

run:
	python bitmessage-update.py
install: build
	sudo gdebi --non-interactive pybitmessage-stable-updater_UNSTABLE.deb
uninstall:
	sudo apt-get purge pybitmessage-stable-updater
build:
	sudo make build-deb
build-deb:
	mkdir -p debian;
	mkdir -p debian/DEBIAN;
	mkdir -p debian/usr;
	mkdir -p debian/usr/bin;
	mkdir -p debian/usr/share;
	mkdir -p debian/usr/share/applications;
	mkdir -p debian/etc;
	mkdir -p debian/etc/xdg;
	mkdir -p debian/etc/xdg/autostart;
	# copy over the launcher for the menu so normal users can run
	# the program
	cp -vf PyBitmessage.desktop ./debian/usr/share/applications/
	cp -vf PyBitmessage.desktop ./debian/etc/xdg/autostart/
	# copy over the binary
	cp -vf bitmessage-update.sh ./debian/usr/bin/bitmessage-update
	# make the program executable
	chmod go-wx ./debian/usr/bin/bitmessage-update
	chmod u+rwx ./debian/usr/bin/bitmessage-update
	# Create the md5sums file
	find ./debian/ -type f -print0 | xargs -0 md5sum > ./debian/DEBIAN/md5sums
	# cut filenames of extra junk
	sed -i.bak 's/\.\/debian\///g' ./debian/DEBIAN/md5sums
	sed -i.bak 's/\\n*DEBIAN*\\n//g' ./debian/DEBIAN/md5sums
	sed -i.bak 's/\\n*DEBIAN*//g' ./debian/DEBIAN/md5sums
	rm -v ./debian/DEBIAN/md5sums.bak
	# figure out the package size
	du -sx --exclude DEBIAN ./debian/ > Installed-Size.txt
	# copy over package data
	cp -rv debdata/. debian/DEBIAN/
	# fix permissions in package
	chmod -Rv 775 debian/DEBIAN/
	chmod -Rv ugo+r debian/
	chmod -Rv go-w debian/
	chmod -Rv u+w debian/
	# build the package
	dpkg-deb --build debian
	cp -v debian.deb pybitmessage-stable-updater_UNSTABLE.deb
	rm -v debian.deb
	rm -rv debian
