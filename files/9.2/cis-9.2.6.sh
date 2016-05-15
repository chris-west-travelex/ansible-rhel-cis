#!/bin/bash

RET=0

if [ "`echo $PATH | /bin/grep :: `" != "" ]; then
	echo "Empty Directory in PATH (::)"
  RET=1
fi

if [ "`echo $PATH | /bin/grep :$`" != "" ]; then
  echo "Trailing : in PATH"
  RET=1
fi

p=`echo $PATH | /bin/sed -e 's/::/:/' -e 's/:$//' -e 's/:/ /g'`
set -- $p

while [ "$1" != "" ]; do
  if [ "$1" = "." ]; then
    echo "PATH contains ."
    RET=1
    shift
    continue
  fi

  if [ -d $1 ]; then
    dirperm=`/bin/ls -ldH $1 | /bin/cut -f1 -d" "`
    if [ `echo $dirperm | /bin/cut -c6 ` != "-" ]; then
      echo "Group Write permission set on directory $1"
      RET=1
    fi
    if [ `echo $dirperm | /bin/cut -c9 ` != "-" ]; then
      echo "Other Write permission set on directory $1"
      RET=1
    fi
    dirown=`ls -ldH $1 | awk '{print $3}'`
    if [ "$dirown" != "root" ] ; then
      echo $1 is not owned by root
      RET=1
    fi
  else
    echo $1 is not a directory
    RET=1
  fi
  shift
done

exit $RET
