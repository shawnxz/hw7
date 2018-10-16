#!/bin/bash
#SBATCH --mail-type=ALL 			# Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=xu.3.zhang@uconn.edu	# Your email address
#SBATCH --ntasks=1				# Run a single serial task
#SBATCH --cpus-per-task=1     # Number of cores to use
#SBATCH --mem=2048mb				# Memory limit
#SBATCH --time=0:10:00				# Time limit hh:mm:ss
#SBATCH -e error_ap.log				# Standard error
#SBATCH -o output_ap.log				# Standard output
#SBATCH --job-name=ap			# Descriptive job name
#SBATCH --partition=serial
module load singularity

# run the afni_proc.py script
cd /scratch/psyc5171/xuz17008
singularity run /scratch/psyc5171/containers/burc-lite.img /scratch/psyc5171/xuz17008/ap.sh
