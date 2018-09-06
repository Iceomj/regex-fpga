# regex-fpga
Simple example for regex ID-search on FPGA
# User Instructions
---

## How to run regex-fpga
Before starting to use this project, you need to install Altera's OpenCL SDK toolset on a Linux desktop computer, on which a supported FPGA board is also correctly installed. Clone this project to your own dictionary. Put all the data files in the ./jsonfiles folder. The data files can be generated by the example datagen.py.



/host       --------Code that run on CPU side

/device     --------OpenCL resource code for development (run on FPGA) 

/bin        --------binary files include how to load the aocx file to FPGA board

/jsonfiles  --------data files

/common     --------basic library for  OpenCL SDK


Simply start the Compiling by typing
```
cd {project}
cd device/src
aoc -v --report ./regex11.cl -o regex11  //run the compiling on FPGA side
#aoc -v -march=emulator ./regex11.cl  //(optional, run the compiling on emulator for debug)
```


after the compiling you will get a .aocx file:
```
cp regex11.aocx ../../bin
cd ../../bin
aocl program acl0 ./regex11.aocx
```
if THE FPGA board is setuped correctly, the command "aocl" will success with no errors.

```
cd {project}
make
```
The Makefile mainly compiles the host side code.

If everything is OK, you can run the FPGA or emulator by:
```
./run_emulator.sh
./run.sh 10

```
The scripts above can be revised to meet different needs.
After running the run.sh or run_emulator.sh, you will get the kernel running time and the results. The results show how many IDs are in the jsonfiles.
