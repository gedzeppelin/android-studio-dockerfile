# Android Studio Dockerfile
<a href="https://hub.docker.com/r/gedzeppelin/android-studio">
  <img src="https://developer.android.com/images/brand/Android_Robot.png"  width="250">
</a>

My Android Studio docker build with GUI and USB device support. 

## Requirements
* Obviously, [Docker](https://www.docker.com/), a program that performs operating-system-level virtualization (also known as containerization).

## Instalation
First of all, clone the repository and cd to it:
```
git clone git@github.com:gedzeppelin/android-studio-dockerfile.git
cd android-studio-dockerfile
```

Then build the docker image and name (and optionally tag) it:
```
docker build --rm -t <image_name>[:<image_tag>] .
```

## Usage
You can run the Android Studio docker image with docker or docker-compose:

### With GUI support
```
docker run -d --name <container_name> -u $(id -u):$(id -g) -e=DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro [-v </local/project/folder>:/home/developer/AndroidStudioProjects] <image_name>[:<image_tag>]
```

### With GUI and USB device support
```
docker run -d --name <container_name> -u $(id -u):$(id -g) -e=DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro --privileged -v /dev/bus/usb:/dev/bus/usb [-v /local/project/folder>:/home/developer/AndroidStudioProjects] <image_name>[:<image_tag>]
```

### With docker-compose
First you will need to modify the .env file to match your settings, then exectute the following command:

```
docker-compose up -d
```