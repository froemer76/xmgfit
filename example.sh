#!/bin/sh
# This is an example to show who to incorporate xmgfit direct in shell scripts.

data_file='linear.dat'
fit_equation='a0*x+a1'

# execute xmgfit with -s option and evaluate the return
eval $(./xmgfit $data_file $fit_equation -s)

# the result set values can now processed further,
# e.g. for output:
echo "Fit of equation y(x)=$fit_equation to data points in $data_file gives"
echo "a0 = $_a0 and a1 = $_a1 ."
echo "The properties of the fit are:"
echo " - Chi-square: $_ChiSq"
echo " - Correlation coefficient: $_CorC"
echo " - RMS per cent error: $_RMS"
echo " - Theil U coefficent: $_TheilU"
