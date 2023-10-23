# Job-Array Example
Example of Slurm Job Array([Definition 1](https://slurm.schedmd.com/job_array.html); [Definition 2](https://docs.alliancecan.ca/wiki/Job_arrays)) example for python functions. 

This example dispatches multiple tasks with different parametrizations contained in a CSV file. The user can feed parameters on such CSV but also paths for file reading, which makes this interface very customizable. Users should be aware that the efficiency of this approach is bounded by a myriad of factors, especially cluster job management policies.
