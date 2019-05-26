#!/bin/bash

set +x

NODENAME=$(hostname)
FILENAME="logs/${SLURM_PROCID}-${NODENAME}.log"
echo $NODENAME $CUDA_VISIBLE_DEVICES $SLURM_PROCID >> $FILENAME
sleep 60s
