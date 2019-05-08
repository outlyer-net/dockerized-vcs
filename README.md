# Dockerized VCS

A dockerized [Video Contact Sheet *NIX](https://p.outlyer.net/vcs/).

This docker image provides a reference working environment for vcs.

This image is meant for troubleshooting although it can conceivably be used as a viable way to run vcs.

## Obtaining the image

Prebuilt images are to be found at Docker Hub. It can be downloaded with:

    sudo docker pull outlyernet/vcs

In case you need to build, use the usual:

    sudo docker build -t vcs .

## Running

This image works by default on the `/mnt` directory, the simplest way to use it is to bind a directory with videos to `/mnt`.

For example, if `/home/user/videos` contains a `sample.mp4` video file...

    $ pwd
    /home/user/videos/
    $ ls
    sample.mp4

... the image can be run like:

    $ sudo docker run --rm -v "$(pwd):/mnt" --user $(id -u):$(id -g) outlyernet/vcs sample.mp4 [your vcs options]
    stty: 'standard input': Inappropriate ioctl for device
    Video Contact Sheet *NIX v1.13.3, (c) 2007-2017 Toni Corvera
    Processing sample.mp4...
    [...]
    Cleaning up...
    $ ls
    sample.mp4 sample.mp4.png

### Arguments explained

The arguments to the above command are:

* `--rm`: Destroy the container when done.
* `-v "$(pwd):/mnt"`: _Bind_ the current directory to `/mnt` (the container's `/mnt` will be an _alias_ for the directory you're running the command from).
* `--user $(id -u):$(id -g)`: Run as your user instead of as `root`, which is the default on Docker. Otherwise the produced files will be owned by `root`.

## Links

* [Video Contact Sheet *NIX homepage](https://p.outlyer.net/vcs/)
* [dockerized vcs at github](https://github.com/outlyer-net/dockerized-vcs/)
* [dockerized vcs at Docker Hub](https://hub.docker.com/r/outlyernet/vcs)