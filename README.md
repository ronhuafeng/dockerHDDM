# A HDDM 0.8.0 docker image with ipyparallel

## What is HDDM? 
HDDM is a python package for hierarchical drift diffusion modelling, see [here](http://ski.clps.brown.edu/hddm_docs/index.html) for more.

## Why I build this docker image?
There was a very nice HDDM docker image by Mads ([@madslupe](https://hub.docker.com/r/madslupe/hddm)). However, this docker image doesn't include `ipyparallel`, a package we need to run multiple chains in **parallel**. Given that running multiple chains to check the convergence is part of routine in Bayesian data analysis now, it's important to make this process easier and faster. `ipyparallel` can help us if we use HDDM. 

## How to use this docker image

First, install docker and test it. There are many tutorial on this, here is one on [docker's website](https://docs.docker.com/engine/install/ubuntu/) for linux.

Then, just pull the docker image from docker hub:

```
docker pull hcp4715/hddm:example
```

**Note**: you may need sudo permission to run `docker`.

After pulling it from docker hub, you can then run jupyter notebook in the container (e.g., in bash of linux):

```
docker run -it --rm --cpus=5 \
-v /home/hcp4715/Data_Analysis/HDDM:/home/jovyan/hddm \
-p 8888:8888 hcp4715/hddm:example jupyter notebook
```

`docker run` ---- Run a docker image in a container

`-it` ---- Keep STDIN open even if not attached

`--rm` ---- Automatically remove the container when it exits

`--cpus=5` ---- Number of cores will be used by docker

`-v` ---- Mount a folder to the container

`/home/hcp4715/Data_Analysis/HDDM` ---- The directory of a local folder where I stored my data. Note, this part might be different in Windows system.

`/home/jovyan/hddm` ---- The directory inside the docker image, or the mounting point of my data folder in the docker image.

`-p` ---- Publish a container’s port(s) to the host

`hcp4715/hddm:example` ---- The docker image to run

`jupyter notebook` ---- Open juypter notebook when start running the container.

After running the code above, bash will has output like this:

```
....
To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-6-open.html
Or copy and paste one of these URLs:
    http://174196acc395:8888/?token=75f1a7a8ffcbb55f0c2802433a9a5d57ac00868e05089c09
 or http://127.0.0.1:8888/?token=75f1a7a8ffcbb55f0c2802433a9a5d57ac00868e05089c09
```

Copy the url (http://127.0.0.1:8888/?.......) to a browser (firefox or chrome) and it will show a web page, this is the interface of jupyter notebook! Note, in Windows system, it might be `localhost` instead of `127.0.0.1` in the url.

Under the `Files` tab, there should be three folders: `work`, `example`, and `hddm`. The `hddm` folder is the local folder mounted in docker container. The `example` folder was the one built in docker image, this folder includes one dataset and one jupyter notebook, you can test the parallel processing by running this jupyter notebook.

Enter `hddm` folder, you can start your analysis within jupyter notebook.

Note that before diving into the jupyter notebook and start analysis, don't forget start multiple engines under the `IPython Clusters` tab in the jupyter notebook window.

![screenshot for ipython clusters](pic/icluster.png)

The number of engines started should be less than or equals to the number of cores of your machine. Later, when run parallel processing, the number of the engines should be less or equals to the number of engines you started here. If mulitiple engines haven't been started before running the parallel processing, the following error will occur:

```
OSError: Connection file '~/.ipython/profile_default/security/ipcontroller-client.json' not found.

You have attempted to connect to an IPython Cluster but no Controller could be found.

Please double-check your configuration and ensure that a cluster is running.
```

## Using example
You can also use the example, without mounting a local folder to the docker container. The example data set is from [my previous study](https://collabra.org/articles/10.1525/collabra.301/). The example jupyter notebook is used to test the `ipyparallel` package. Run the following code to use the example.

```
docker run -it --rm --cpus=5 \
-p 8888:8888 hcp4715/hddm:example jupyter notebook
```

## Potential errors
* Permission denied. Please see this [post](https://groups.google.com/forum/#!topic/hddm-users/Qh-aOC0N6cU) about the permission problem.

## How this docker image was built
An alternative way to get the docker image is to build it from `Dockerfile`.

I built this docker image under Ubuntu 20.04. 

This Dockerfile is modified by Dr. Rui Yuan @ Stanford, based on the Dockerfile of [jupyter/scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook/dockerfile). We installed additional packages for HDDM and `ipyparallel`, and configured the `ipyparallel` so that we can run it in jupyter noebook (doesn't work for jupyterlab yet). See `Dockerfile` for the details

Code for building the docker image (don't forget the `.` in the end):

```
docker build -t hcp4715/hddm:example -f Dockerfile .
```

## Acknowledgement
Thank [@madslupe](https://github.com/madslupe) for his previous HDDM image, which laid the base for the current version.

Thank [Dr Rui Yuan](https://scholar.google.com/citations?user=h8_wSLkAAAAJ&hl=en) for his help in creating the Dockerfile.

## Report issues
If you have any problem in using this docker image, please report an issue at the [github repo](https://github.com/hcp4715/hddm_docker/issues) 