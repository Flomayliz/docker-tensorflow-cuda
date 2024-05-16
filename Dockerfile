# syntax=docker/dockerfile:1.3.0-labs
# "syntax=docker/dockerfile:1.3.0-labs" 

ARG BASE=nvidia/cuda:12.4.0-devel-ubuntu22.04
FROM $BASE

# change BASE accordingly
ARG USER=lita
ARG PASSWORD=lita
ARG UID=1000
ARG GID=1000

# Setup timezone
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# necessary update
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC && \
    apt-get update && apt-get install -y --no-install-recommends \
    wget ca-certificates git openssh-server sudo vim curl libpam-cracklib tzdata dumb-init screen && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

#-------- add a new user --------
RUN addgroup --gid ${GID} ${USER} && \
    adduser --uid ${UID} --gid ${GID} --gecos "" --disabled-password ${USER} && \
    usermod -G root,sudo ${USER} && \
    echo "${USER}:${PASSWORD}" | chpasswd


# switch user
ENV PATH "/home/$USER/.local/bin:$PATH"
USER ${USER}
WORKDIR /home/${USER}
ENV PATH=/home/${USER}/.conda/bin:$PATH \
    HOME=/home/${USER}

# Install anaconda (python)
RUN curl -o ~/anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh && \
    chmod +x ~/anaconda.sh && \
    /bin/bash ./anaconda.sh -b -p /home/${USER}/.conda && \
    rm ~/anaconda.sh && \
    conda config --system --prepend channels conda-forge && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    pip install --upgrade pip
 
# Install pytorch
RUN --mount=type=cache,mode=0777,target=/home/${USER}/.cache,uid=${UID},gid=${GID} \
    pip install torch==2.3.0+cu121 torchvision==0.18.0+cu121 torchaudio==2.3.0+cu121 --index-url https://download.pytorch.org/whl/cu121

# Install tensorflow
RUN --mount=type=cache,mode=0777,target=/home/${USER}/.cache,uid=${UID},gid=${GID} \
    pip install tensorflow[and-cuda] tensorflow_datasets --default-timeout=100

# Initialize jupyter
RUN --mount=type=cache,mode=0777,target=/home/${USER}/.cache,uid=${UID},gid=${GID} \
    jupyter notebook --generate-config && \
    jupyter server --generate-config