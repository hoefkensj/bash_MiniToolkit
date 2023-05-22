#!/usr/bin/env bash
# set -o xtrace;
set -o errexit;
set -o nounset;
function chrootprep {
	function mountlog(){
		printf 'mounting %s ...\t' $1
		printf 'mount %s /%s %s/%s\n' "$2" "$1" "$NR" "$1" 
	}
	local NR
	NR=$(realpath "$1" )
	echo $NR	
	echo cp -v --dereference /etc/resolv.conf "${NR}/etc/"
	cp -v -L --dereference /etc/resolv.conf "${NR}/etc/"
	mountlog "proc" "-v -t proc"       && mount -v -t proc       none   "${NR}/proc"       
    mountlog "sys" "-v --rbind"        && mount -v --rbind       /sys   "${NR}/sys"
    mountlog "sys" "-v --make-rslave"  && mount -v --make-rslave        "${NR}/sys"
 	mountlog "dev" "-v --rbind"        && mount -v --rbind       /dev   "${NR}/dev"
    mountlog "dev" "-v --make-rslave"  && mount -v --make-rslave        "${NR}/dev"
	mountlog "run" "-v --bind"         && mount -v --bind        /run   "${NR}/run"
    mountlog "run" "-v --make-slave"   && mount -v --make-slave         "${NR}/run" 
    test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
	mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm
	chmod 1777 /dev/shm 
}  
chrootprep "$@"