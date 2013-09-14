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
	mv $javav/* .
	rm -r $javav $javaf
}

function checkjava() {
	if [ $(javac -version 2>&1 | head -n 1 | grep '[ "]1\.[6][\. "$$]') ]; then
		installed=1
	else
		installed=0	
	fi
}

function setpath() {
	export JAVA_HOME=`pwd`/$installpath/bin/java
	export PATH=`pwd`/$installpath/bin:$PATH
	echo -e "Java paths set"
}

#first check if system java is correct
checkjava

if [ $installed = 1 ]; then
	echo -e "System Java is the correct version"
  elif [ ! -d "$installpath" ]; then
	echo -e "Error: Java not found, downloading..."
	mkdir $installpath; cd $installpath
	getjava
	setpath
	checkjava
  elif [ "-d "$installpath"" -a "$installed = 0" ]; then
	setpath
	checkjava
	if [ $installed = 1 ]; then
		echo -e "Correct java version installed"
	fi
fi
