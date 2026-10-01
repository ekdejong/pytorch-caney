# Based on: https://hpc.llnl.gov/documentation/user-guides/using-pytorch-lc/pytorch-weave-quickstart-guide
module load weave/develop-gpu
/usr/apps/weave/tools/create_venv.sh -p gpu -e my-weave-env -v latest-develop
source my-weave-env/bin/activate

weave create_jupyter_kernel --kernel_name 'weave-env' --kernel_display_name 'WEAVE env'
pip install numpy==1.26.4
pip install lightning
pip install datasets
pip install timm
pip install yacs

# test
python -c 'import torch ; print(torch.rand(5, 3)) ; print("Torch Version", torch.__version__) ; print("GPU available:", torch.cuda.is_available())'