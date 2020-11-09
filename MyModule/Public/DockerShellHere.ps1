# Run a shell (bash) in docker and mount current directory as workdir
# From https://blog.ropnop.com/docker-for-pentesters/
Function DockerShellHere {
    param()

    $workdir = Split-Path -Path ${PWD} -Leaf

    $dockeroptions = @(
        "--rm", "-it"
        "-v", "${PWD}:/${workdir}"
        "-w", "/${workdir}"
        "--entrypoint", "/bin/bash"
    )

    & docker run @dockeroptions $args
}
