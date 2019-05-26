#!/bin/bash
#SBATCH --job-name test-multi-nodes
#SBATCH --account research
#SBATCH --gres gpu:1
#SBATCH --mem-per-cpu 1G
#SBATCH --nodes 1-4
#SBATCH --ntasks 4
#SBATCH --ntasks-per-node 4
#SBATCH --cpus-per-task 2
#SBATCH --time 6:00:00
#SBATCH --partition long
#SBATCH --output test-multi-nodes.log

set -x 
env | grep "SLURM"
set +x

rm logs/*.log
mkdir -p logs/
echo "hostname CUDA_VISIBLE_DEVICES SLURM_PROCID" > logs/00-something.log
srun --ntasks 4 bash worker.sh
set -x
pdsh -w $SLURM_NODELIST echo "Hello World!"
set +x

scontrol show job $SLURM_JOB_ID

echo "--------------------"
cat logs/*.log | column -t
echo "--------------------"

