#!/bin/bash
#This script compute increment and decrement derivatives for each atom environement (AE) in the AE library (see file:AE_library/Atom_AE_1_bond_sorted.txt )
#Author: Oanh Vu
#Date: Jan 2019

#specify path to bcl executable
#bcl=/path/to/BCL/build/linux64_release/bin/bcl-apps-static.exe
# Specify number of cpu cores used
cpu_n=10

# generate bin files
cat sdf.lst| xargs -n1 -I@ -P $cpu_n $bcl descriptor:GenerateDataset -source 'SdfFile(filename=@.sdf)' -feature_labels Atom1.object -result_labels '0' -output @.bin

#compute increment derivatives
cat sdf.lst | xargs -n1 -I@ -P $cpu_n $bcl descriptor:ScoreDataset -source 'Subset(filename=@.bin)' -output @_increment.score -opencl Disable -score 'InputSensitivityDiscrete(derivative=Increment,storage=File(directory=qsar_2689, prefix=model), weights=(consistency=0.0,square=0.0,absolute=0.0,utility=0.0,average=1.0,consistency best=0.0,balance=False,categorical=False))' -scheduler PThread 10  -feature_labels Atom1.object

#compute decrement derivatives
cat sdf.lst | xargs -n1 -I@ -P $cpu_n $bcl descriptor:ScoreDataset -source 'Subset(filename=@.bin)' -output @_decrement.score -opencl Disable -score 'InputSensitivityDiscrete(derivative=Decrement,storage=File(directory=qsar_2689, prefix=model), weights=(consistency=0.0,square=0.0,absolute=0.0,utility=0.0,average=1.0,consistency best=0.0,balance=False,categorical=False))' -scheduler PThread 10  -feature_labels Atom1.object
