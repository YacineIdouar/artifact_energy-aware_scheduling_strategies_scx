#! /bin/bash

# Start mesure on channel 1
node-conso -M 1
# Measuring for 30s
node-conso -t 30 > $1
# Stop measure
node-conso -m 1
