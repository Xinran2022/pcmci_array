#!/bin/bash

# The indices list is then consumed by the slurm --array argument,
# which for every task, gets into a Slurm Array Task ID

# The time/mem/cpus flag, is max time per task (default below 3h to get higher priority)

# The array 2-1000 corresponds to the index 2,3,4,...,1000 range, contained on parameters.csv

#SBATCH --job-name=ja_ex
#SBATCH --output=./slurm_runs/%j-%u-%x-%N.out
#SBATCH --error=./slurm_runs/%j-%u-%x-%N.err
#SBATCH --array=1-1597612
#SBATCH --time=00:15:00
#SBATCH --account=rrg-ggalex
#SBATCH --mem-per-cpu=100G   # 2 GB of memory per CPU
#SBATCH --cpus-per-task=44  # 4 CPUs per task
#SBATCH --mail-user=gaox67@mcmaster.ca
#SBATCH --mail-type=ALL

# Set the csv header size (1 contains only a first line, often containing column titles)
header_offset=1

# Load python 3.11.5 (please customize given your workload - perhaps with a python venv)
module load StdEnv/2023 python/3.11.5

# Adjust SLURM_ARRAY_TASK_ID to account for the header line
adjusted_task_id=$((SLURM_ARRAY_TASK_ID + header_offset))

# Extracting parameters using sed and awk
line=$(sed -n "${adjusted_task_id}p" hl.csv)
index=$(echo $line | awk -F, '{print $1}')
row=$(echo $line | awk -F, '{print $2}')
col=$(echo $line | awk -F, '{print $3}')
sm=$(echo $line | awk -F, '{print $4}')
evi=$(echo $line | awk -F, '{print $5}')
var_names0=$(echo $line | awk -F, '{print $6}')
var_names1=$(echo $line | awk -F, '{print $7}')

# Running the python script with the extracted parameters
python main.py --index "$index" --row "$row" --col "$col" --sm "$sm" --evi "$evi" --var_names0 "$var_names0" --var_names1 "$var_names1"
