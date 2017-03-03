#! /bin/bash
########################################################################
# Script to update PyBitmessage from the source git repository
# Copyright (C) 2017  Carl J Smith
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
########################################################################
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
