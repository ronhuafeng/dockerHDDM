# Create a docker image for HDDM 0.8.0

### What is HDDM? 
HDDM is a python package for hierarchical drift diffusion modelling, see [here](http://ski.clps.brown.edu/hddm_docs/index.html) for more.

### Why I build this docker image?
There was a very nice [HDDM docker image](https://registry.hub.docker.com/r/madslupe/hddm) by Mads. However, this docker image doesn't include `ipyparallel`, a package enable us to run multiple chains in **parallel**. However, running multiple chains to check the convergence is part of Bayesian modelling, it's important to make this easier for HDDM too. So far, using `ipyparallel` is the only way I knew, so I tried to include this package also in docker image.

### How this docker image was built

I built this docker image under Ubuntu 20.04. 

First, install docker and test it. There are many tutorial on this, here is one on [docker's website](https://docs.docker.com/engine/install/ubuntu/).

Second, build the docker image from `Dockerfile`.

This Dockerfile is modified by Dr. Rui Yuan @ Stanford from [jupyter/scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook/dockerfile). We installed additional packages for HDDM and `ipyparallel`, and configured the `ipyparallel` so that we can run it in jupyter noebook (doesn't work for jupyterlab yet). See `Dockerfile` for the details

Code for building the docker image (don't forget the `.` in the end):

```
docker build -t hcp4715/hddm:0.8.0 -f Dockerfile .
```
### How to use this docker image

After built this image or pull it from docker hub, you can then run jupyter notebook in the container (in bash of linux):

```
docker run -it --rm --cpus=5 \
-v /home/hcp4715/Results/Data_Analysis/HDDM:/home/jovyan/hddm \
-p 8888:8888 hcp4715/hddm:test jupyter notebook
```
`docker run` -- run a docker image in a container

`-it` -- 

`-v` -- mount a folder to the container

`/home/hcp4715/Results/Data_Analysis/HDDM` is the directory where I stored my data. 

`-p` -- port

`hcp4715/hddm:test` -- the docker image to run

`jupyter notebook` -- open juypter notebook when start running the container.

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

### Acknowledgement
Thanks @madslupe for his version of HDDM image.

Thanks Dr Rui Yuan for his help in making the Dockerfile.