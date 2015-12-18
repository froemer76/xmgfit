#!/bin/sh
# This shell script checks if xmgfit works properly on your machine.
echo '\nTest if xmgfit works properly on your machine:'

# check if xmgrace is available
type xmgrace >/dev/null 2>&1 && { \
      echo >&2 ' + xmgrace found'; \
      } || { \
	echo >&2 " -> Error! I require 'xmgrace' but it's not installed. Aborting."; \
	exit 1; }

# check if xmgfit is available and where
xmgf=''
type xmgfit >/dev/null 2>&1 && { \
	echo >&2 " + xmgfit found in \$PATH";\
      xmgf='xmgfit';\
	} || { \
      echo >&2 " - xmgfit not found in \$PATH";\
      }
type ./xmgfit >/dev/null 2>&1 && { \
	echo >&2 " + xmgfit found local";\
      xmgf='./xmgfit';\
	} || { \
      echo >&2 " - xmgfit not found local";\
      }
[ ! $xmgf ] && { echo " -> xmgfit not found anywhere! Aborting!"; exit 1;}

# check if test data files are available
if [ -r linear.dat ] && [ -r square.dat ]; then
      echo ' + test data files found'
else
      echo '-> test data files not found! Aborting!' 
      exit 1
fi

# test: do two fit procedures and compare results
error=0
echo -n '-> do test '
eval $($xmgf linear.dat a0*x+a1 -s)
[ $_a0 = '4.47848' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_a1 = '3.39022' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_ChiSq = '164.075' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_CorC = '0.998182' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_RMS = '0.141285' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_TheilU = '0.0302247' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }

eval $($xmgf square.dat a0+a1*x+a2*x^2 -s)
[ $_a0 = '63.4911' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_a1 = '4.15215' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_a2 = '3.98625' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_ChiSq = '4839.29' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_CorC = '0.997358' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_RMS = '0.129001' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
[ $_TheilU = '0.045383' ] && { echo -n '.';} || { echo -n 'x'; error=$(($error+1)); }
echo ' done!'

# result of test
if [ $error -eq 0 ]; then
      echo 'No errors detected, xmgfit seems to work fine! :)\n'
      exit 0
else
      echo "Error(s) occur, $error result set value(s) differ(s)! :(\n"
      exit 1
fi

