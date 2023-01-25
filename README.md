# Docker multi-provider minecraft server with Lazymc

A docker image for Minecraft servers with Lazymc. It can use a variety of
providers, currently:

- [Fabric](https://fabricmc.net/) is a "lightweight, experimental modding
  toolchain for Minecraft".
- [PaperMC](https://github.com/PaperMC/Paper) is a "high performance Spigot fork
  that aims to fix gameplay and mechanics inconsistencies".
- [Purpur](https://github.com/PurpurMC/Purpur) is a "drop-in replacement for
  Paper servers designed for configurability, and new fun and exciting gameplay
  features".

[Lazymc](https://github.com/timvisee/lazymc) puts your Minecraft server to rest
when idle, and wakes it up when players connect.

Inspired by
[mcserver-lazymc-docker](https://github.com/Okazakee/mcserver-lazymc-docker)

## Quick start

Something along these lines should get you started:

```sh
docker run -p 25565:25565 -p 25566:25566 -it -v (pwd)/server_data:/data joaocostaifg/multiprovider-lazymc:1.19.3-lazymc0.2.7x64-purpur
```

## Usage details

Just bind-mount your Minecraft server folder to /data:

```sh
docker run -v https://github.com/Okazakee/mcserver-lazymc-docker joaocostaifg/multiprovider-lazymc:1.19.3-lazymc0.2.7x64-purpur
```

When running the server for the first time, you'll likelly be prompted to accept
the EULA. Just edit the `eula.txt` file accordingly and restart the container.
You can find multiple build for different Minecraft versions at the
[project's DockerHub page](https://hub.docker.com/repository/docker/joaocostaifg/multiprovider-lazymc/general).

### Environment variables

The following environment variables are optional:

- `MC_RAM_MIN` - the minimum amount of RAM reserved for the server. Defaults to
  512 MB.
- `MC_RAM_MAX` - the maximum amount of RAM the server can use. Defaults to 1G,
  which is likely too conservative.
- `JAVA_OPTS` - you can pass extra arguments for the Java virtual machine, e.g.,
  `--add-modules=jdk.incubator.vector`

### Build options

There some build options to tweak, e.g.,
`docker build --build-arg MC_VERSION=1.19.3`:

- `CPU_ARCHITECTURE` - the CPU architecture. Either `aarch64`, `armv7`, `x64`,
  or `x64-static`
- `LAZYMC_VERSION` - probably should just go with `latest`, but you can provide
  a version number, e.g., `0.2.7`
- `SERVER_PROVIDER` - which server to use. Currently, it supports
  [purpur](https://github.com/PurpurMC/Purpur),
  [paper](https://github.com/PaperMC/Paper), and
  [fabric](https://fabricmc.net/). Defaults to `purpur`
- `MC_VERSION` - the Minecraft version.

## TODO

- ~~Find a way to connect to the container and run commands on the server
  command line~~:
  - Ok,
    [docker attach](https://docs.docker.com/engine/reference/commandline/attach/)
    exists
- Add support for forge:
  - How to download the latest version (maybe parse html)
- What to do about the libraries directory of fabric and forge:
  - Probably should just stay in the maps directory

## License

Just threw in there an [MIT license](./LICENSE) as usual.
