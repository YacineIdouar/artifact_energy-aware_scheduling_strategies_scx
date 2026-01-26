#!/bin/bash

# Launching loose policy with EEVDF

#./scripts/1_generic_run_scheds.py -N x7ti -S guided
#./scripts/1_generic_run_scheds.py -N x7ti -S loose

############## A- Nvidia bpfland scheduler ##################################
echo "Launch of bpfland"
~/scx/target/release/scx_bpfland -s 20000 -S &
bpfland_pid=$!
sleep 1
./scripts/1_generic_run_scheds.py -N x7ti -S guided -X bpfland
./scripts/1_generic_run_scheds.py -N x7ti -S loose  -X bpfland
kill ${bpfland_pid}
echo "End of bpfland"
############################################################################
############################################################################
############## B- Valve lavd scheduler #####################################
echo "Launch of lavd default"
~/scx/target/release/scx_lavd --autopilot &
lavd_pid=$!
sleep 1
./scripts/1_generic_run_scheds.py -N x7ti -S guided -X lavd
./scripts/1_generic_run_scheds.py -N x7ti -S loose  -X lavd
kill ${lavd_pid}
echo "End of lavd default"
############################################################################
############################################################################
######################## C- Nvidia rusty ###################################
echo "Launch of rusty default"
~/scx/target/release/scx_rusty -c 2 -o 20000 --no-load-balance &
lavd_pid=$!
sleep 1
./scripts/1_generic_run_scheds.py -N x7ti -S guided -X rusty
./scripts/1_generic_run_scheds.py -N x7ti -S loose  -X rusty
kill ${lavd_pid}
echo "End of rusty default"
