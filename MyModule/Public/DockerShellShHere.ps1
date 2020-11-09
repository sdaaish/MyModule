# Run a shell (sh) in docker and mount current directory as workdir
# From https://blog.ropnop.com/docker-for-pentesters/
Function DockerShellShHere {
    param()

    $workdir = Split-Path -Path ${PWD} -Leaf

    $dockeroptions = @(
        "--rm", "-it"
        "-v", "${PWD}:/${workdir}"
        "-w", "/${workdir}"
        "--entrypoint", "/bin/sh"
    )

    & docker run @dockeroptions $args
}
