#!/bin/bash
# Script to download the java binaries (if needed) and set up the java paths
# Copyright 2013 Evan Anderson

javaf="jdk-6u45-linux-x64.bin"
javadl="http://download.oracle.com/otn-pub/java/jdk/6u45-b06/$javaf"
javav="jdk1.6.0_45"
installpath="java"

function getjava() {
	wget -q --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "$javadl"
	chmod +x $javaf
	./$javaf &> /dev/null
}

function checkjava() {
	if [[ "javac -version" == *1.6* ]]; then
		echo -e "Java SDK 1.6 found"
	fi
}

function setpath() {
	export JAVA_HOME=pwd/$installdir/$javav/bin
	export PATH=pwd/$installdir/$javav:$PATH
	echo -e "Java paths set"
}

if [ ! -d "$installpath" ]; then
	echo -e "Error: Java not found, downloading..."
	mkdir $installpath; cd $installpath
	getjava
	setpath
	checkjava
   else if [ -d "$installpath" ]; then
	setpath
	checkjava
   fi
fi
