Android Studio (3.5.1) docker build with GUI and USB device support, source on this GitHub [repository](https://github.com/gedzeppelin/tomcat-dockerfile).

## Usage
You can run the Android Studio docker image with your local projects.

### With GUI support
```
docker run -d [--name <container_name>] -u $(id -u):$(id -g) -e=DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro [-v </local/project/folder>:/home/developer/AndroidStudioProjects] gedzeppelin/android-studio[:<tag>]
```

### With GUI and USB device support
```
docker run -d [--name <container_name>] -u $(id -u):$(id -g) -e=DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro --privileged -v /dev/bus/usb:/dev/bus/usb [-v </local/project/folder>:/home/developer/AndroidStudioProjects] gedzeppelin/android-studio[:<tag>]
```