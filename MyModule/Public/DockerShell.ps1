# Run a shell (bash) in docker
# From https://blog.ropnop.com/docker-for-pentesters/
Function DockerShell {
    param()

    $dockeroptions = @(
        "--rm", "-it"
        "--entrypoint", "/bin/bash"
    )

    & docker run @dockeroptions $args
}
