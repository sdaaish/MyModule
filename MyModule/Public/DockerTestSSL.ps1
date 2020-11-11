# Test SSL for an address
Function DockerTestSSL {
    param()

    $dockeroptions = @(
        "--rm"
        "sdaaish/testssl.sh"
        "--hints", "--fast"
        "--quiet", "-S"
    )

    & docker run @dockeroptions $args
}
