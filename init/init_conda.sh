#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will install Anaconda Python on the local machine. This 
    is to enable Conda environments to be used.

  If the path isn't correctly added, this can be completed manually through 
    the following commands:

        export PATH="$HOME/conda/bin/activate:$PATH"
        source ~/.bashrc

  If you'd prefer that conda's base environment not be activated on startup, 
    set the auto_activate_base parameter to false: 

  conda config --set auto_activate_base false

  If installing in a global space for everyone you will need to update all individual's .bashrc files with the initialise script.


    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
            . "/opt/conda/etc/profile.d/conda.sh"
        else
            export PATH="/opt/conda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<


  Create an environment with:
    conda create --name dbt python

    conda create -c conda-forge -p ./python3.11 python=3.11 

    conda activate dbt

  Create a Kernel
    python -m ipykernel install --user --name=<env name>

  Check kernel
    jupyter kernelspec list

COMMENT


sudo apt install -y python3-pip

# ANACONDA_VERSION=Anaconda3-2022.10-Linux-x86_64.sh
# wget https://repo.anaconda.com/archive/${ANACONDA_VERSION}
# sudo chmod +x ${ANACONDA_VERSION}
# sudo ./${ANACONDA_VERSION} -u
# rm ${ANACONDA_VERSION}


# Install Miniconda and add to path
MINICONDA_VERSION=Miniconda3-py310_22.11.1-1-Linux-x86_64.sh
wget -c https://repo.anaconda.com/miniconda/${MINICONDA_VERSION}
chmod +x ${MINICONDA_VERSION}
./${MINICONDA_VERSION} -u
rm ${MINICONDA_VERSION}

# Add to path - /opt/conda
echo 'export PATH="/opt/conda/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc


# venv setup
# pip3 install virtualenv
# python3 -m venv ~/python3.11
# python3.11 -m pip install --upgrade pip
# To run in venv 