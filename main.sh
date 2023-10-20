#!/bin/bash

# Example of Slurm job array, adapted from The Alliance documentation (https://docs.alliancecan.ca/wiki/Job_arrays).
# Every task is self-contained (not depending on other tasks). Be careful to environment setup.

# Set the csv header size (1 contains only a first line, often containing column titles)
header_offset=1

# Increment each index value by header_offset to account for the header line in the CSV file
indices=$(awk -v offset=$header_offset -F, 'NR > 1 {print $1 + offset}' parameters.csv | sort -n | tr '\n' ',' | sed 's/,$//')

echo "$indices" >> indices.txt

# The indices list is then consumed by the slurm --array argument,
# which for every task, gets into a Slurm Array Task ID
# The --time flag, is max time per task (default below 3h to get higher priority)

#SBATCH --job-name=ja_ex
#SBATCH --output=out_%j.txt
#SBATCH --error=err_%j.txt
#SBATCH --array=${indices}
#SBATCH --time=00:30:00
#SBATCH --account=def-ggalex
#SBATCH --mem-per-cpu=2G   # 2 GB of memory per CPU
#SBATCH --cpus-per-task=4  # 4 CPUs per task

# Load python 3.11.5 (please customize given your workload - perhaps with a python venv)
module load StdEnv/2023 python/3.11.5

echo "This task ID#: $SLURM_ARRAY_TASK_ID"

# Adjust SLURM_ARRAY_TASK_ID to account for the header line
adjusted_task_id=$SLURM_ARRAY_TASK_ID

# Extracting parameters using sed and awk
line=$(sed -n "${adjusted_task_id}p" parameters.csv)
index=$(echo $line | awk -F, '{print $1}')
temperature=$(echo $line | awk -F, '{print $2}')
category=$(echo $line | awk -F, '{print $3}')

# Debugging echo
echo "Debugging - Index: $index, Temperature: $temperature, Category: $category" >> debug.txt

# Running the python script with the extracted parameters
python main.py --index "$index" --temperature "$temperature" --category "$category"