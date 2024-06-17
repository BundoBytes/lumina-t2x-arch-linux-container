FROM archlinux

EXPOSE 8080

ENV HUGGINGFACE_API_KEY="" PACMAN_FLAGS="--noconfirm --needed" VISUAL=nvim EDITOR=nvim CUDA_HOME=/usr/local/cuda-12.1

# Configure package managers:
RUN pacman -Syu $PACMAN_FLAGS \
    && pacman -S git --noconfirm
RUN pacman -S git neovim nnn locate sudo libgl base-devel wget ripgrep $PACMAN_FLAGS

# Add sudo 'dev' user with no password:
RUN useradd -m dev && echo 'dev ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER dev
WORKDIR /home/dev
SHELL ["bash", "-c"]

# Copy dotfiles for neovim:
RUN mkdir .config
COPY ../config/nvim  ~/.config

# Install 'yay', the AUR package manager:
RUN git clone https://aur.archlinux.org/yay.git \
  && cd yay \
  && makepkg -si --noconfirm

RUN wget https://www.python.org/ftp/python/3.11.8/Python-3.11.8.tgz \
  && chmod +x Python-3.11.8.tgz \
  && tar -xf Python-3.11.8.tgz \
  && cd Python-3.11.8 \
  && ./configure --enable-optimization \
  && make \
  && sudo make install

# Install cuda:
RUN wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda_12.1.1_530.30.02_linux.run
RUN sudo sh cuda_12.1.1_530.30.02_linux.run --override --silent --toolkit

# Configure venv:
RUN python3 -m venv lumina-t2i \
  && source ~/lumina-t2i/bin/activate \
  && pip3 install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 \
  && pip3 install -U fairscale gradio safetensors wheel torchdiffeq packaging
RUN source ~/lumina-t2i/bin/activate \
  && pip3 install flash_attn diffusers transformers accelerate \
  && huggingface-cli login --token hf_xxxx_my_api_key_here_xxx


RUN git clone https://github.com/Alpha-VLLM/Lumina-T2X.git \
  && cd Lumina-T2X

# Create script to run the demo.py:
RUN echo "source /home/dev/lumina-t2i/bin/activate" > ~/launch_demo.sh \
  && echo "cd /home/dev/Lumina-T2X/lumina_next_t2i" >> ~/launch_demo.sh \
  && echo "python3 -u demo.py --ckpt=\"/home/dev/projects/lumina-t2x-arch-linux-container/models\"" >> ~/launch_demo.sh \
  && chmod +x ~/launch_demo.sh

CMD ["bash"]
