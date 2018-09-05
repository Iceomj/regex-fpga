#!/bin/bash
export CL_CONTEXT_COMPILER_MODE_ALTERA=3
lines=${1:-10}
./bin/host -jsonline=$lines -jsonfile="./jsonfiles/${lines}_gen.json"
