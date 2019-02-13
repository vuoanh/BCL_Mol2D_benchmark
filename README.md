# BCL_Mol2D_benchmark
This repo contains scripts to perform the benchmark and sensitivity analysis in the paper *BCL::Mol2D – a robust atom environment descriptor for QSAR modeling and lead optimization*

## 1. Download and install BCL

The **Bio Chemical Library (BCL)** is a software package that provides a suite of cheminformatics tools that allow construction of quantitative structure-activity-relation (QSAR) models for virtual screening, pharmacophore mapping, and drug design. BCL is free of charge for non-comercial use.

Follow the instruction on [this page](http://meilerlab.org/index.php/servers/bcl-academic-license) to obtain access to the source code of BCL.

## 2. Benchmark different descriptor configurations in QSAR tasks

In the `benchmark` folder:
### Make dataset bin files
- Download the smi string file of nine PubChem datasets [here](http://www.meilerlab.org/jobs/downloadfile/name/qsar_benchmark_smiles.zip). Convert the smi string files to SDF files with 3D conformation using OpenBabel and Corina as described in the method section of the paper. 
Store the sdf files in the `data` folder. 

- In the `data` folder, make the bin data files by running:

```
./make_bin_files.sh
```

### Train the QSAR models

Train and benchmark the QSAR models with different descriptor configurations by running this script:

```
qsar_train.sh
```

The computational jobs can be performed locally or on computer cluster via srun (see the script)

## 3.Sensitivity analysis
In the `sensitivity_analysis` folder:

Compute the decrement and increment dervatives of different atom environments for each active and inactive compound by running:

```
./compute_sensitivity_scores.sh
```
