#! /bin/bash
if [ -d /opt/PyBitmessage ];then
	echo 'Upgrading current install of PyBitmessage...';
	# checkout the files with unmodified permissions for update
	git -C /opt/PyBitmessage checkout /opt/PyBitmessage/*;
	# pull updates to pybitmessage
	git -C /opt/PyBitmessage pull;
else
	# create pybitmessage source directory
	mkdir -p /opt/PyBitmessage;
	# clone the source, this will auto set the origin of the project
	git clone https://github.com/Bitmessage/PyBitmessage /opt/PyBitmessage;
fi
echo 'Fixing file permissions on source directory...';
# set permissions on everything so users do not have write access
chmod -v -R go-w /opt/PyBitmessage/*;
