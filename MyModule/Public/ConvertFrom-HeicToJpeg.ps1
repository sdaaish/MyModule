Function ConvertFrom-HeicToJpeg {
    $dockeroptions = @(
        "--rm"
        "-v", "${PWD}:/convert"
        "wshelley/heic-to-jpeg"
    )
    & docker run @dockeroptions
}
