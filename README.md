# comfyui-arch-linux-container
A simple OCI script to launch a container that runs ComfyUI.

The script uses podman, but you should be able to replace it with 'docker' to work with Docker instead.

Run lumina_create_container.sh to build the container and run it.

> - IMPORTANT #1: You need to provide a Huggingface API key that has write permissions and has access
    to 'https://huggingface.co/google/gemma-2b'.
    Lumina's demo.py fetches this LLM using 'huggingface-cli'.
>
> - IMPORTANT #2: Re-running 'lumina_create_container' will delete the old container and rebuild it.


Run lumina_launch.sh to start an existing container.
