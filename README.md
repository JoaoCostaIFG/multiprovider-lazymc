# Purpur minecraft server with Lazymc

A docker image for Purpur Minecraft server with Lazymc.

[Purpur](https://github.com/PurpurMC/Purpur) is a "drop-in replacement for Paper
servers designed for configurability, and new fun and exciting gameplay
features".

[Lazymc](https://github.com/timvisee/lazymc) puts your Minecraft server to rest
when idle, and wakes it up when players connect.

Inspired by
[mcserver-lazymc-docker](https://github.com/Okazakee/mcserver-lazymc-docker)

## Quick start

Something along these lines should get you started:

```sh
docker run -p 25565:25565 -p 25566:25566 -it -v (pwd)/server_data:/data joaocostaifg/lazymc-purpur:1.19.3-lazymc0.2.7x64
```

## Usage details

Just bind-mount your Minecraft server folder to /data:

```sh
docker run -v https://github.com/Okazakee/mcserver-lazymc-docker joaocostaifg/lazymc-purpur:latest
```

When running the server for the first time, you'll likelly be prompted to accept
the EULA. Just edit the `eula.txt` file accordingly and restart the container.
You can find multiple build for different Minecraft versions at the
[project's DockerHub page](https://hub.docker.com/repository/docker/joaocostaifg/lazymc-purpur/general).

### Build options

There some build options to tweak, e.g.,
`docker build --build-arg MC_VERSION=1.19.3`:

- `CPU_ARCHITECTURE` - the CPU architecture. Either `aarch64`, `armv7`, `x64`,
  or `x64-static`
- `LAZYMC_VERSION` - probably should just go with `latest`, but you can provide
  a version number, e.g., `0.2.7`
- `MC_VERSION` - the Minecraft version.
- `MC_RAM_MIN` - the minimum amount of RAM reserved for the server. Defaults to
  512 MB.
- `MC_RAM_MAX` - the maximum amount of RAM the server can use. Defaults to 1G,
  which is likely too conservative.

### Extra args

You can pass extra arguments for the Java virtual machine by appending them to
the docker run call, e.g.:

```sh
docker run -it -v server_data:/data joaocostaifg/lazymc-purpur:latest --add-modules=jdk.incubator.vector
```