#!/bin/bash
#
# Quick test script for PyTorch-Caney examples
#

echo "================================================"
echo "Quick PyTorch-Caney Test"
echo "================================================"
echo ""

# request interactive node and activate conda environment
flux alloc -N1 -n1 -t 1h
flux resource list

# Load ROCm module for AMD GPU support
echo "Loading ROCm module..."
module load rocm/6.2.4
echo ""

conda activate pytorch-caney

# Check GPU (AMD/ROCm instead of NVIDIA)
echo "GPU Status:"
if command -v rocm-smi &> /dev/null; then
    echo "Running rocm-smi..."
    rocm-smi
elif command -v rocminfo &> /dev/null; then
    echo "Running rocminfo..."
    rocminfo | grep -E "Marketing Name|Memory Size"
else
    echo "No ROCm GPU tools found. PyTorch will check GPU at runtime..."
fi
echo ""

# Set Python path
export PYTHONPATH=~/.conda/envs/pytorch-caney
cd /usr/workspace/wsa/dejong5/pytorch-caney

echo "Running FCN Baseline test..."
echo ""

python pytorch_caney/ptc_cli.py --config-path configs/LOCAL_3dcloudtask_fcn_baseline_test.yaml > emily_test_fcn.out 2>&1

echo ""
echo "Test complete!"
