# Fluent Bit Docker Image

[Fluent Bit](http://fluentbit.io) Docker image based on Alpine Linux.

## 1. Build image

Use `docker build` command to build the image. This example names the image "custom-fluent-bit:latest":

```
docker build -t custom-fluent-bit:latest ./
```

## 2. Test it

Once the image is built, it's ready to run. Following commands run Fluentd sharing `./log` directory with the host machine:

```
docker run -it custom-fluent-bit:latest
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
