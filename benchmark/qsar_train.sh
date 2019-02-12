#!/bin/bash

#number of local cpu cores
cpu_n=10

# train QSAR models
for descriptor in 'Element1RSR' 'Atom1RSR' 'Element2' 'Atom2' 'Element1' 'Atom1' 'RSR'
do

  #run locally
  cat datasets.lst | xargs -n1 -I@ python /path/to/BCL/scripts/machine_learning/launch.py -t cross_validation --config-file qsar.config --datasets data/@_${descriptor}.bin --id @_${descriptor} --features feature_labels/${descriptor}.object  --opencl None --local $cpu_n --override-memory-multiplier 1.5

  # For running on computer cluster using srun
  #cat datasets.lst | xargs -n1 -I@ python /path/to/BCL/scripts/machine_learning/launch.py -t cross_validation --config-file qsar.config --datasets data/@_${descriptor}.bin --id @_${descriptor} --features feature_labels/${descriptor}.object --slurm --just-submit  --no-flock-submit --opencl None --override-memory-multiplier 1.5

done
