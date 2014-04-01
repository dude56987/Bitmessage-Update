#! /usr/bin/python
from os.path import exists
from os import system
from os import chdir
if exists('/opt/PyBitmessage') and exists('/usr/bin/git') and exists('/usr/bin/openssl') and exists('/usr/bin/git') :
	print ('Upgrading current install of PyBitmessage...')
	chdir('/opt/PyBitmessage')
	system('sudo git pull')
else:
	system('sudo apt-get install python openssl git python-qt4 --assume-yes')
	system('sudo mkdir -p /opt/PyBitmessage')
	system('sudo git clone https://github.com/Bitmessage/PyBitmessage /opt/PyBitmessage')
