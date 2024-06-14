## Docker image for a single-user JupyterLab environment with DynexSDK pre-installed
This docker image is wrapped with the DynexSDK to allow users a quicker method for using Dynex n.quantum.
This docker has all your environment setup as well as everytime the environment boots, it will auto update DynexSDK for you.

## Build the image from Docker Hub
```shell
$> docker build -t dynex/jupyterlab .
```

## Run the container
In your terminal, navigate to your notebooks directory if you have one.
```shell
docker pull dynex/jupyterlab
```

Open your browser to [localhost:8888](http://localhost:8888)

## Notes
Please note that this docker image is designed to be run as a standalone system.
This system is not designed to be deployed on anything other than a local system.

Using this system on a public frontend is not advised, for a version that is designed for internet facing please use 
```shell
docker pull dynex/octaspace
```