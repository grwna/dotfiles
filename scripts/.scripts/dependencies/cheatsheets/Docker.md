# Docker Cheatsheets

`[]` - denotes parameters
`<>` - denotes optional parameters

# Container Lifecycle

| command                                                               | description                                        |
| --------------------------------------------------------------------- | -------------------------------------------------- |
| `docker run -d -p [host_port]:[container_port] --name [name] [image]` | run container in background with port mapping      |
| `docker run -it [image] [shell]`                                      | run container interactively (e.g., `bash` or `sh`) |
| `docker ps`                                                           | list running containers                            |
| `docker ps -a`                                                        | list all containers (including stopped)            |
| `docker start\|stop\|restart [container]`                             | manage container lifecycle                         |
| `docker rm [container]`                                               | remove a stopped container                         |
| `docker rm -f [container]`                                            | force remove a running container                   |

# Inspection & Debugging

| command                             | description                              |
| ----------------------------------- | ---------------------------------------- |
| `docker logs -f [container]`        | stream logs from container               |
| `docker exec -it [container] [cmd]` | execute command inside running container |
| `docker inspect [container\|image]` | detailed metadata in JSON format         |
| `docker stats`                      | live stream of container resource usage  |

# Images & Registry

| command                                    | description                  |
| ------------------------------------------ | ---------------------------- |
| `docker build -t [name]:[tag] [path]`      | build image from Dockerfile  |
| `docker images`                            | list local images            |
| `docker rmi [image]`                       | remove local image           |
| `docker pull [image]`                      | download image from registry |
| `docker push [image]`                      | upload image to registry     |
| `docker tag [source_image] [target_image]` | re-tag an existing image     |

# Networks & Volumes

| command                        | description                 |
| ------------------------------ | --------------------------- |
| `docker volume ls`             | list all persistent volumes |
| `docker volume create [name]`  | create named volume         |
| `docker network ls`            | list all networks           |
| `docker network create [name]` | create bridge network       |

# System Cleanup

| command                            | description                                                  |
| ---------------------------------- | ------------------------------------------------------------ |
| `docker system prune -a`           | remove stopped containers, unused networks & dangling images |
| `docker system prune -a --volumes` | full wipe: includes all unused volumes                       |

# Docker Compose

| command                               | description                                       |
| ------------------------------------- | ------------------------------------------------- |
| `docker compose up -d`                | build and start services in background            |
| `docker compose down`                 | stop and remove containers, networks, and volumes |
| `docker compose ps`                   | list service containers                           |
| `docker compose logs -f <service>`    | tail logs for all or specified service            |
| `docker compose exec [service] [cmd]` | run command inside service container              |

# Common Patterns

| command                                                | description                               |
| ------------------------------------------------------ | ----------------------------------------- |
| `docker run --rm -it [image]`                          | run ephemeral container (deletes on exit) |
| `docker run -v [host_path]:[container_path] [image]`   | bind-mount host directory into container  |
| `docker run -v [volume_name]:[container_path] [image]` | mount named volume into container         |

# Notes
- The short `docker run` is recently marked as legacy. It is recommended to use the management syntax (container, image, volume)
- `--name` assigns a human-readable identifier to containers
- Use `.dockerignore` to keep image builds small and fast
