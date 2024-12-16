# Kestrel-Resources

## Running Jupyter on a Compute Node

*The Easy Way*  
`ssh -L <local_port>:<compute_node>:<remote_port> <username>@<hpc_login_node>`  
for example: `10.150.8.40` is the compute node ip  
`ssh -L 8787:10.150.8.40:8787 tford@kestrel.hpc.nrel.gov`  



1. Start the compute node  
`salloc --time=240 --account=pvfem --partition=shared --ntasks=26 --mem-per-cpu=2000 --nodes=1` - shared node  
Aliased by `node-pvdeg`
   
2. Start the jupyter server  
`jupyter-notebook --no-browser --ip=0.0.0.0 --port=8888`

3. Port forward to login node  
Port forward from compute node to login node.  
ON LOGIN NODE: `ssh -L 8888:localhost:8888 <compute node>`  
This assumes that the jupyter serve is running on port 8888.  
   
4. Port forward to local machine  
Port forward from login node to local machine.  
ON LOCAL MACHINE: `ssh -L 8888:localhost:8888 username@login-node-address`  
FOR ME: `ssh -L 8888:localhost:8888 tford@kestrel.hpc.nrel.gov`

5. Access the jupyter server  
Visit http://localhost:8888/

## User Configurations
[myaliases](myaliases)
[mymods](mymods)

## Config Files
[vimrc](.vimrc)
