#!/usr/bin/env bash
set -x
yum -q -y install dos2unix
dos2unix /vagrant/scripts/jupyterinapache.sh
/vagrant/scripts/jupyterinapache.sh add vagrant 8901 /jupyter /var/log/jupyter.log
# install pyfmi
# the rest as vagrant
tail -n +$[LINENO+2] $0 | exec sudo -u vagrant bash                                                                                                                                                                                                     
exit $? 
# install pyfmi and mamba
/home/vagrant/jupyter/bin/conda install -q -y -c conda-forge pyfmi mamba
/home/vagrant/jupyter/bin/mamba install sos sos-pbs sos-notebook jupyterlab-sos sos-bash sos-python -c conda-forge
# install julia dependencies for jupyter (ijulia) and demo notebook using rdatasets
/home/vagrant/julia-1.3.0/bin/julia -e "using Pkg; Pkg.add(\"IJulia\");Pkg.add(\"RDatasets\");Pkg.add(\"Gadfly\")"
sudo systemctl stop jupyter
sudo systemctl start jupyter
exit 0