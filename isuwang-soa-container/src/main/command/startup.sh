#!/usr/bin/env bash

workdir=`pwd`
dirname $0|grep "^/" >/dev/null
if [ $? -eq 0 ];then
   workdir=`dirname $0`
else
    dirname $0|grep "^\." >/dev/null
    retval=$?
    if [ $retval -eq 0 ];then
        workdir=`dirname $0|sed "s#^.#$workdir#"`
    else
        workdir=`dirname $0|sed "s#^#$workdir/#"`
    fi
fi

cd $workdir

logdir=$workdir/../logs
if [ ! -d "$logdir" ]; then
	mkdir "$logdir"
fi

nohup java -jar ./lib/isuwang-soa-container.jar  > $logdir/nohup.out 2>&1 &
echo $! > $logdir/pid.txt