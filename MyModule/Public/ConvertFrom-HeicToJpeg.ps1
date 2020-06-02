Function ConvertFrom-HeicToJpeg {
    docker run -v ${PWD}:/convert wshelley/heic-to-jpeg
}
