# windows cannot use a shebang line
"""#!/usr/bin/env python"""

import argparse
import subprocess

def setup_port_forwarding(port: int, compute_node: str = None, username: str = 'tford', address: str = 'kestrel-jhub.hpc.nrel.gov'):
    if compute_node:
        ssh_command = [
            "ssh", "-L", f"{port}:{compute_node}:{port}", f"{username}@{address}"
        ]
    else:
        ssh_command = [
            "ssh", "-L", f"{port}:localhost:{port}", f"{username}@{address}"
        ]
    
    print(f"Executing: {' '.join(ssh_command)}")
    
    try:
        subprocess.run(ssh_command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error executing SSH command: {e}")
    except KeyboardInterrupt:
        print("SSH forwarding interrupted. Exiting.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Set up SSH port forwarding to an HPC login node or compute node.")
    parser.add_argument("-p", "--port", type=int, required=True, help="Local and remote port to forward")
    parser.add_argument("-u", "--username", type=str, default="tford", help="SSH username (default: tford)")
    parser.add_argument("-a", "--address", type=str, default="kestrel-jhub.hpc.nrel.gov", help="Login node address (default: kestrel-jhub.hpc.nrel.gov)")
    parser.add_argument("-c", "--compute", type=str, help="Compute node IP address. If set, forwards port to compute node instead of localhost.")
    
    args = parser.parse_args()
    
    # If using a compute node, change the default HPC login node
    if args.compute:
        args.address = "kl2.hpc.nrel.gov"
    
    setup_port_forwarding(args.port, args.compute, args.username, args.address)
