# Fluent Bit Docker Image

[Fluent Bit](http://fluentbit.io) Docker image based on Debian.

## 1. Build image

Use `make` command to build the images. Before starting the arm32v7 platform build, you need to run this registry, so you can perform a cross-build. Just follow the documentation: https://github.com/multiarch/qemu-user-static/blob/master/README.md

```sh
$ TARGET_ARCHITECTURE=[arm32v7, x86_64, (nothing to build all architectures)] make
```

## 2. Push it

Use `make push` command to push the image, TARGET_ARCHITECTURE is necessary.

```sh
$ TARGET_ARCHITECTURE=[arm32v7, x86_64] make push
```

## 3. Test it

Once the image is built, it's ready to run:

```sh
$ docker run -p 127.0.0.1:24224:24224 fluent/fluent-bit:[TAGNAME]
```

By default, the configuration set a listener on TCP port 24224 through Forward protocol and prints to the standard output interface each message. So this can be used to forward Docker log messages from one container to the Fluent Bit image, e.g:

```sh
$ docker run --log-driver=fluentd -t ubuntu echo "Testing a log message"
```


On Fluent Bit container will print to stdout something like this:

```
Fluent-Bit v0.12.9
Copyright (C) Treasure Data

[0] docker.31c94ceb86ca: [1487548735, {"container_id"=>"31c94ceb86cae7055564eb4d65cd2e2897addd252fe6b86cd11bddd70a871c08", "container_name"=>"/admiring_shannon", "source"=>"stdout","}]og"=>"Testing a log message
```

## Contact

Feel free to join us on our Mailing List or IRC:

 - Slack: http://slack.fluentd.org / channel #fluent-bit
 - Mailing List: https://groups.google.com/forum/#!forum/fluent-bit
 - IRC: irc.freenode.net #fluent-bit
 - Twitter: http://twitter.com/fluentbit

## License

This program is under the terms of the [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

## Authors

[Fluent Bit](http://fluentbit.io) is made and sponsored by [Treasure Data](http://treasuredata.com) among other [contributors](https://github.com/fluent/fluent-bit/graphs/contributors).
