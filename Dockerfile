FROM ubuntu:latest
LABEL maintainer="gedy.palomino@gmail.com"

ARG USER=developer
ARG LOCALE=America/Lima

# Adding 32 bits repositories
RUN dpkg --add-architecture i386
# Updating the system
RUN apt-get -y update 
RUN apt-get -y upgrade
# Installing prerequisites
RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
# Installing Java
RUN apt-get install -y default-jdk
# Installing utils
RUN apt-get install -y make sudo git vim usbutils android-tools-adb android-tools-fastboot locales
# Installing KVM
RUN apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
# Purging apt-get
RUN apt-get autoremove -y \
	&& \
	apt-get clean

# Creating a sudo user with home folder
RUN useradd -ms /bin/bash $USER
RUN usermod -aG sudo $USER
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-$USER 
RUN adduser $USER libvirt
RUN usermod -aG plugdev $USER

# Adding udev rules for android USB debugging
ADD https://github.com/M0Rf30/android-udev-rules/blob/master/51-android.rules /etc/udev/rules.d/51-android.rules
RUN chmod a+r /etc/udev/rules.d/51-android.rules

# Download and unzip Android Studio for Linux
ADD https://dl.google.com/dl/android/studio/ide-zips/3.4.2.0/android-studio-ide-183.5692245-linux.tar.gz /opt/android-studio.tar.gz
RUN cd /opt/ && tar -xvzf android-studio.tar.gz && rm android-studio.tar.gz

# Setting locales
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV TZ=${LOCALE}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Change current user and workdir
USER $USER
WORKDIR /home/$USER

# Command to start
CMD /opt/android-studio/bin/studio.sh
