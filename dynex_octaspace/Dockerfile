# Change BASE. https://hub.docker.com/r/nvidia/cuda
ARG BASE=nvidia/cuda:12.2.0-devel-ubuntu22.04
FROM $BASE

# User Variables
ARG USER=dynex
ARG UID=1000
ARG GID=1000

# Setup timezone
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# necessary update
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC && \
    apt-get update && apt-get install -y --no-install-recommends \
    wget ca-certificates git unzip nano g++ make cmake sudo vim curl libpam-cracklib tzdata dumb-init screen && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

#-------- add a new user --------
RUN addgroup --gid ${GID} ${USER} && \
    adduser --uid ${UID} --gid ${GID} --gecos "" --disabled-password ${USER} && \
    usermod -G root,sudo ${USER}

# switch user
ENV PATH "/home/$USER/.local/bin:$PATH"
USER ${USER}
WORKDIR /home/${USER}
ENV PATH=/home/${USER}/.conda/bin:$PATH \
    HOME=/home/${USER}

# Install miniconda (python)
RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py310_23.5.2-0-Linux-x86_64.sh && \
    chmod +x ~/miniconda.sh && \
    /bin/bash ./miniconda.sh -b -p /home/${USER}/.conda && \
    rm ~/miniconda.sh && \
    conda config --system --prepend channels conda-forge && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple && \
    pip install --upgrade pip

# install ipykernel, jupyter, pytorch, and tensorflow
RUN --mount=type=cache,mode=0777,target=/home/${USER}/.cache,uid=${UID},gid=${GID} \
    pip install ipykernel==6.25.2 && \
    pip install notebook==7.0.4 jupyterlab==4.0.6 && \
    pip install torch==2.0.1+cu118 torchvision==0.15.2+cu118 torchaudio==2.0.2+cu118 --index-url https://download.pytorch.org/whl/cu118 && \
    pip install transformers==4.33.3 scipy==1.11.3 SentencePiece==0.1.99 accelerate==0.23.0 bitsandbytes==0.41.1 && \
    pip install protobuf==4.24.3 tensorflow==2.14.0

# set plugins and kernels for jupyter
RUN --mount=type=cache,mode=0777,target=/home/${USER}/.cache,uid=${UID},gid=${GID} \
    pip install matplotlib==3.8.0 jupyter_http_over_ws==0.0.8 nbconvert==7.8.0 traitlets==5.10.1 nbclassic==1.0.0 && \
	pip install dynex dimod numpy matplotlib && \
    jupyter notebook --generate-config && \
    jupyter server --generate-config && \
    jupyter server extension enable --py jupyter_http_over_ws

RUN conda init

# allow utf-8 characters in terminal
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN mkdir ${HOME}/testnet
COPY --chmod=0755 ./dynex-testnet-bnb ${HOME}/testnet/dynex-testnet-bnb

RUN wget https://raw.githubusercontent.com/dynexcoin/DynexSDK/main/Dynex_hello_world.ipynb -P ${HOME}

# install frequently used packages & make sure to keep DynexSDK up to date every boot
RUN --mount=type=cache,mode=0777,target=/home/${USER}/.cache,uid=${UID},gid=${GID} \
    pip install -U dynex

EXPOSE 8888:8888

COPY ./entrypoint.sh ${HOME}/.entrypoint.sh
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD bash ${HOME}/.entrypoint.sh