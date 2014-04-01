show:
	echo 'Run "make install" as root to install program!'
	
run:
	python bitmessage-update.py
install:
	sudo apt-get install python openssl git python-qt4
	sudo cp bitmessage-update.py /usr/bin/bitmessage-update
	sudo chmod +x /usr/bin/bitmessage-update
	sudo link /usr/bin/bitmessage-update /etc/cron.monthly/bitmessage-update
	sudo cp -vf PyBitmessage.desktop /usr/share/applications
uninstall:
	sudo rm /usr/bin/bitmessage-update
	sudo rm /etc/cron.monthly/bitmessage-update
	sudo rm /usr/share/applications/PyBitmessage.desktop
	sudo rm -fvr /opt/PyBitmessage
installed-size:
	du -sx --exclude DEBIAN ./debian/
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
	# make post and pre install scripts have the correct permissions
	chmod 775 debdata/*
	# copy over the binary
	cp -vf bitmessage-update.py ./debian/usr/bin/bitmessage-update
	# make the program executable
	chmod +x ./debian/usr/bin/bitmessage-update
	# start the md5sums file
	find ./debian/ -type f -print0 | xargs -0 md5sum > ./debian/DEBIAN/md5sums
	sed -i.bak 's/\.\/debian\///g' ./debian/DEBIAN/md5sums
	sed -i.bak 's/\\n*DEBIAN*\\n//g' ./debian/DEBIAN/md5sums
	sed -i.bak 's/\\n*DEBIAN*//g' ./debian/DEBIAN/md5sums
	# clean up
	rm -v ./debian/DEBIAN/md5sums.bak
	cp -rv debdata/. debian/DEBIAN/
	dpkg-deb --build debian
	cp -v debian.deb pybitmessage-stable-updater_UNSTABLE.deb
	rm -v debian.deb
	rm -rv debian
