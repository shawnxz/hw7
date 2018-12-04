#!/bin/bash
#SBATCH --mail-type=ALL 			# Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=xu.3.zhang@uconn.edu	# Your email address
#SBATCH --ntasks=1				# Run a single serial task
#SBATCH --cpus-per-task=1     # Number of cores to use
#SBATCH --mem=4096mb				# Memory limit
#SBATCH --time=1:00:00				# Time limit hh:mm:ss
#SBATCH -e error_ap_%a.log				# Standard error
#SBATCH -o output_ap_%a.log				# Standard output
#SBATCH --job-name=ap			# Descriptive job name
#SBATCH --partition=serial
#SBATCH --array=1-10
module load singularity

# run the afni_proc.py script
cd /scratch/psyc5171/xuz17008/hw7/
singularity run /scratch/psyc5171/containers/burc-lite.img /scratch/psyc5171/xuz17008/hw7/ap.sh

subj=`printf "%02d" $SLURM_ARRAY_TASK_ID`

# run the afni_proc.py script
cd /scratch/psyc5171/xuz17008/hw7
for session in test retest; do
	singularity run /scratch/psyc5171/containers/burc-lite.img \
	/scratch/psyc5171/xuz17008/hw7/ap.sh $subj $session
	singularity run /scratch/psyc5171/containers/burc-lite.img \
	/scratch/psyc5171/xuz17008/hw7/run_afni_${subj}-${session}.sh
done
	