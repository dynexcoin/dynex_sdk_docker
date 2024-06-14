## Docker image for a deployable JupyterLab environment with DynexSDK pre-installed on Octa.Space
This docker image is wrapped with the DynexSDK to allow users a quicker method for using Dynex n.quantum.
This docker has all your environment setup as well as everytime the environment boots, it will auto update DynexSDK for you.
This docker image has be specifically designed for deployment on https://octa.space infrastructure 

## Build the image from Docker Hub
```shell
$> docker build -t dynex/octaspace .
```

## Run the container
In your terminal, navigate to your notebooks directory if you have one.
```shell
docker pull dynex/octaspace
```

Open your browser to the URL supplied by Octa.Space - This service runs on port ```80``` by default

## Notes
Please note that this docker image is designed to be run as a deployable solution on https://octa.space
This system has been specifically coded for octa.space, using this on other deployable services might have unforseen errors

If you wish to have just a standalone version to use please use the following
```shell
docker pull dynex/jupyterlab
```