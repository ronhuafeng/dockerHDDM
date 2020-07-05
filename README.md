# Create a docker image for HDDM 0.8.0

### What is HDDM? 
HDDM is a python package for hierarchical drift diffusion modelling, see [here](http://ski.clps.brown.edu/hddm_docs/index.html) for more.

### Why I build this docker image?
There was a very nice [HDDM docker image](https://registry.hub.docker.com/r/madslupe/hddm) by Mads (@madslupe). However, this docker image doesn't include `ipyparallel`, a package we need to run multiple chains in **parallel**. Given that running multiple chains to check the convergence is part of Bayesian routine now, it's important to make it easier for running HDDM too. 

### How to use this docker image

First, install docker and test it. There are many tutorial on this, here is one on [docker's website](https://docs.docker.com/engine/install/ubuntu/).

Then, an easy way to use this image is to pull it from docker hub:

```
docker pull hcp4715/hddm:ipyparallel
```
Note: you may need sudo permission to run docker.

After pulling it from docker hub, you can then run jupyter notebook in the container (in bash of linux):

```
docker run -it --rm --cpus=5 \
-v /home/hcp4715/Results/Data_Analysis/HDDM:/home/jovyan/hddm \
-p 8888:8888 hcp4715/hddm:ipyparallel jupyter notebook
```
`docker run`:     run a docker image in a container

`-it`:       Keep STDIN open even if not attached

`--rm`:     Automatically remove the container when it exits

`--cpus=5`: Number of cores will be used by docker

`-v`: mount a folder to the container

`/home/hcp4715/Results/Data_Analysis/HDDM`: the directory of a local folder where I stored my data. 

`-p`: Publish a container’s port(s) to the host

`hcp4715/hddm:ipyparallel`:   the docker image to run

`jupyter notebook`:     Open juypter notebook when start running the container.

After running the code above, bash will has output like this:

```
....
To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-6-open.html
Or copy and paste one of these URLs:
    http://174196acc395:8888/?token=75f1a7a8ffcbb55f0c2802433a9a5d57ac00868e05089c09
 or http://127.0.0.1:8888/?token=75f1a7a8ffcbb55f0c2802433a9a5d57ac00868e05089c09
```

Copy the url (http://127.0.0.1:8888/?.......) to a browser (firefox or chrome) and it will show a web page, this is the interface of jupyter notebook! 

Under the `Files` tab, there are two folders: `work`, and `hddm`, the `hddm` folder is the folder where I stored your data. Enter this folder, you can start your analysis within jupyter notebook (I already had jupyter notebook in this folder).

Note that before diving into the jupyter notebook and start analysis, don't forget start multiple engines under the `IPython Clusters` tab in the jupyter notebook window.

![screenshot for ipython clusters](pic/icluster.png)

The number of engines started should be less than or equals to the number of cores of your machine. Later, when run parallel processing, the number of the engines should be less or equals to the number of engines you started here.

### How this docker image was built
An alternative way to get the docker image is to build it from `Dockerfile`.

I built this docker image under Ubuntu 20.04. 

This Dockerfile is modified by Dr. Rui Yuan @ Stanford, based on the Dockerfile of [jupyter/scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook/dockerfile). We installed additional packages for HDDM and `ipyparallel`, and configured the `ipyparallel` so that we can run it in jupyter noebook (doesn't work for jupyterlab yet). See `Dockerfile` for the details

Code for building the docker image (don't forget the `.` in the end):

```
docker build -t hcp4715/hddm:ipyparallel -f Dockerfile .
```

### Acknowledgement
Thank @madslupe for his version of HDDM image.

Thank Dr Rui Yuan for his help in making the Dockerfile.