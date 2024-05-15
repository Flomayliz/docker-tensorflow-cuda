## Introduction

This repository contains a Docker image that includes Anaconda, TensorFlow, and PyTorch, all running with GPU acceleration. The container is based on `12.4.1-cudnn-devel-ubuntu22.04` and requires NVIDIA drivers version 550.


## Prerequisites

### Installing NVIDIA drivers.

Before you can proceed with this project, make sure you have the NVIDIA drivers version 550 installed on your system. Follow the steps below to install the drivers:

1. Open a terminal window.

2. Add the NVIDIA package repository to your system's package manager:

    ```bash
    $ sudo add-apt-repository ppa:graphics-drivers/ppa
    ```

3. Update the package lists:

    ```bash
    $ sudo apt update
    ```

4. Install the NVIDIA drivers version 550:

    ```bash
    $ sudo apt install nvidia-drivers-550
    ```

5. Reboot your system to apply the changes:

    ```bash
    $ sudo reboot
    ```

6. Check that the drivers have been installed correctly. 
    ```bash
    $ nvidia-smi
    ```

Once you have successfully installed the NVIDIA drivers version 550, you can proceed with setting up and running your CUDA Python environment.

### Installing Docker with NVIDIA Support

To install Docker with NVIDIA support, follow the steps below:

1. Open a terminal window.

2. Add the NVIDIA container toolkit repository to your system's package manager:

    ```bash
    $ curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
        && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
        sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    ```

3. Update the package lists:

    ```bash
    $ sudo apt update
    ```

4. Install Docker and the NVIDIA container toolkit:

    ```bash
    $ sudo apt install docker-ce docker-ce-cli containerd.io nvidia-container-toolkit
    ```

5. Add your user to the `docker` group to run Docker without `sudo`:

    ```bash
    $ sudo usermod -aG docker $USER
    ```

6. Configure the container runtime by using the nvidia-ctk command:

    ```bash
    $ sudo nvidia-ctk runtime configure --runtime=docker
    ```

7. Restart the Docker daemon:

8. Verify that Docker with NVIDIA support is installed correctly:

    ```bash
    $ docker run --gpus all nvidia/cuda:11.0-base nvidia-smi
    ```

Now you have Docker installed with NVIDIA support and you can proceed with running your CUDA Python environment.

## Deploying the Docker Compose

To deploy the Docker Compose stored in this folder, follow the steps below:

1. Open a terminal window.

2. Navigate to the directory where the `docker-compose.yml` file is located:

    ```bash
    $ cd cuda-python-env/
    ```

3. Build and run the Docker containers using Docker Compose:

    ```bash
    $ docker-compose up
    ```

    This command will build and start the containers defined in the `docker-compose.yml` file.

Now you have successfully deployed the Docker Compose stored in this folder. 