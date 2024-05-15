#!/bin/sh

export CUDNN_PATH=$HOME/.conda/lib/python3.10/site-packages/nvidia/cudnn
export LD_LIBRARY_PATH=$CUDNN_PATH/lib:/usr/local/cuda/lib64:/usr/local/cuda/lib:$LD_LIBRARY_PATH 
export PATH=/usr/local/cuda/bin:$PATH

bash -ic ' jupyter notebook --notebook-dir=/notebooks --ip 0.0.0.0 --no-browser --allow-root --port=9090'