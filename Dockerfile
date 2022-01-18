FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive 

# Install packages
RUN apt update && apt install -y \
lsb-release \
git \
neovim \
tmux \
wget \
curl \
htop \
libssl-dev \
build-essential \
dbus \ 
dbus-x11 \
mesa-utils \
libgl1-mesa-glx \
software-properties-common

# Install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt update && \
    apt install -y ros-noetic-desktop-full python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

# Configure ROS
ENV ROS_DISTRO noetic

RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
