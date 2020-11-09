# Run a shell (sh) in docker
# From https://blog.ropnop.com/docker-for-pentesters/
Function DockerShellSh {
    param()

    $dockeroptions = @(
        "--rm", "-it"
        "--entrypoint", "/bin/sh"
    )

    & docker run @dockeroptions $args
}
