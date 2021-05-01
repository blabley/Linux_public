#!/bin/bash
#############################################################################################################################################
#                                                                                                                                           												#
#                                           			 Script By Clarence J. Proz.host                                                                							#
#                                                   				http://proz.host                                                                                                                                                                                 	#
#                                                                                                                                         												#
#############################################################################################################################################
#############################################################################################################################################
# Loading call
#############################################################################################################################################
loading=( '|' '/' '-' '\' '--0o0o----->' '---o0o0o------->' '-----0o0o0---------->'  '<*------------------------------------------------*>' )
	progress()
{
	for i in "${loading[@]}"
	do
	echo -ne "\r$i"
	sleep 0.1
done
}
######################################################### Loading call end ###########################################################################

##################################################################################################################################################
# Prepare For Install
##################################################################################################################################################
	clear && echo "** SyncThing Auto Installer Starting **"
	progress
	echo ""
	echo ""
	echo " STOP INSTALLER BY PRESSING CTRL+C "
	echo ""	
	echo " ***** SyncThing Auto Installer Is Now Ready ****** "
	progress
	echo ""
	echo ""
#############################################################################################################################################
# Clean Out Old Files Or Files Know To Cause Issues With Install
#############################################################################################################################################
	echo "*** Cleaning up Server and Preparing for install. ***"
	progress
	rm -rf /etc/yum.repos.d/daftaupe-syncthing-epel-7.repo.*
	rm -rf /etc/yum.repos.d/daftaupe-syncthing-epel-7.*
	rm -rf daftaupe-syncthing-epel-7.*.*
	rm -rf daftaupe-syncthing-epel-7.*
	rm -rf /root/.config/syncthing
	rm -rf /usr/bin/syncthing
	rm -rf /usr/lib/systemd/system/syncthing-resume.service
	rm -rf /usr/lib/systemd/system/syncthink@.service
	rm -rf /usr/lib/systemd/user/syncthing.service
	rm -rf /usr/share/licenses/syncthing-1.1.*
	yum remove syncthing -y -q &> /dev/null
	echo ""
	echo "** Done **"
	echo ""
#############################################################################################################################################
# Get Required Files
#############################################################################################################################################
	echo "***** Getting Required Packages & Repo ***** "
	echo ""
	progress
	echo ""
	wget https://copr.fedorainfracloud.org/coprs/daftaupe/syncthing/repo/epel-7/daftaupe-syncthing-epel-7.repo  &> /dev/null
	yum install openssl -y -q &> /dev/null
	echo ""
	echo "** Done **"
	echo ""
############################################################################################################################################
# Install Repo & Packages this may take a while
#############################################################################################################################################
	echo "***** Installing Repo and Packages Required ***** "
	progress
	mv daftaupe-syncthing-*-*.repo /etc/yum.repos.d/
	echo ""
	echo ""
	echo "Installing SyncThing RPM"
	progress
	yum clean all -q &> /dev/null 
	yum update -y -q &> /dev/null
	echo ""
	echo "Please wait still working!"
	yum remove syncthing -y -q &> /dev/null
	yum install syncthing -y -q &> /dev/null
	sleep 2s ;
	echo "done"
	echo ""
	echo "Please enter a non-root new user to run syncThink for security!"
	read user
	progress
	echo ""
	echo ""
	echo "Please enter password for this user!"
	read password
	echo ""
	echo " The username "$user" and password "$password" is all set! "
	echo ""
	progress	
	useradd -p $(openssl passwd -1 "$password") "$user"
	echo ""
	echo "***********************************************************"
	echo "** Please press CTRL+C Once You Have Your My-ID Key Copied! ******"
	echo "***********************************************************"
	echo ""
	progress
	syncthing
	echo ""
	echo "Please wait still working!"
	sleep 5s ;
	echo "Please wait Still working!"
	systemctl enable syncthing@"$user".service &> /dev/null
	sleep 5s ;
	echo ""
	echo "Please wait still working!"
	systemctl start syncthing@"$user".service &> /dev/null
	echo ""
	sleep 5s ;
	systemctl status syncthing@"$user".service &> /dev/null
	sleep 5s ;
	echo "Please wait still working almost done!"
	progress
	echo ""
	echo "Done moving on!" 
	progress
	echo ""
	echo ""
#############################################################################################################################################
# Change Ip with user input
#############################################################################################################################################
echo "Please enter server IP, Hostname or Domain for SyncThing to use." 
echo "( Example: Subdomian.example.com ) Recomended to use IP here!"
read IP
echo ""
echo ""
echo "The IP $IP has been setup in SyncThing config file."
echo ""
echo "***** File Location Of Edited File ******"
echo ""
echo "** /home/$user/.config/syncthing/config.xml **"
echo "***********************************************"
export VAR=$IP
sed -i -e 's/127.0.0.1/'$IP'/g' /home/"$user"/.config/syncthing/config.xml;
#############################################################################################################################################
#############################################################################################################################################
#!END
#############################################################################################################################################
#############################################################################################################################################
