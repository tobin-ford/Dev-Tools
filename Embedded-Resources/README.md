### Micropython Tools

We will use [`rshell`](https://github.com/dhylands/rshell). 

My system has the following alias to access the ESP32.
`alias rs='rshell -p /dev/ttyACM0 --baud 115200'`

We can use `rsync src_dir target_dir` to sync directories. 
`/pyboard` represents the root directory of the board if the name has not been changed.

[Building Micropython](building-micropython.md)
