podman container rm lumina_container --force && podman-compose --podman-build-args='--format docker' build && podman-compose up -d && podman attach lumina_container
