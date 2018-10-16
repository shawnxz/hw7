#!/bin/bash
#SBATCH --mail-type=ALL 			# Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=xu.3.zhang@uconn@uconn.edu	# Your email address
#SBATCH --ntasks=1				# Run a single serial task
#SBATCH --cpus-per-task=1     # Number of cores to use
#SBATCH --mem=8096mb				# Memory limit
#SBATCH --time=2:00:00				# Time limit hh:mm:ss
#SBATCH -e error_afni.log				# Standard error
#SBATCH -o output_afni.log				# Standard output
#SBATCH --job-name=afni			# Descriptive job name
#SBATCH --partition=serial
module load singularity


# run the generated script
cd /scratch/psyc5171/xuz17008
singularity run /scratch/psyc5171/containers/burc-lite.img /scratch/psyc5171/xuz17008/run_afni.sh

