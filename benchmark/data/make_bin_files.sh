#!/bin/bash
bcl=/path/to/BCL/build/linux64_release/bin/bcl-apps-static.exe

# Number of cores used
cpu_n=10

# Make bin files for active and inactive sdf files
for f in '1798' '1834' '2258' '2689' '435008' '435034' '463087' '485290' '488997'
do
  for descriptor in 'Element1RSR' 'Atom1RSR' 'Element2' 'Atom2' 'Element1' 'Atom1' 'RSR'
  do
    $bcl descriptor:GenerateDataset -source 'SdfFile(filename='$f'.active.sdf.gz)' -feature_labels ../feature_labels/${descriptor}.object -result_labels "1" -output ${f}_active_${descriptor}.bin -scheduler PThread $cpu_n
    $bcl descriptor:GenerateDataset -source 'SdfFile(filename='$f'.inactive.sdf.gz)' -feature_labels ../feature_labels/${descriptor}.object -result_labels "0" -output ${f}_inactive_${descriptor}.bin -scheduler PThread $cpu_n

    # Combine and then randomize the active and inactive molecules from each set (see for loop)
    $bcl descriptor:GenerateDataset -source 'Randomize(Combined(Subset(filename='$f'_active_'${descriptor}'.bin), Subset(filename='$f'_inactive_'${descriptor}'.bin)))' -output ${f}_${descriptor}.bin -scheduler PThread $cpu_n
    rm ${f}_active_${descriptor}.bin ${f}_inactive_${descriptor}.bin
  done
done
