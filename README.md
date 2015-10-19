# EventStore - Dockerfile

This is an up-to-date Dockerfile for installing [EventStore](https://geteventstore.com/) without the mono runtime within an `ubuntu:trusty` image as base.

### Building the image

By default it's building the latest (currently `3.3.0`) version.

```sh
$ git clone https://github.com/tPl0ch/docker-event-store.git
$ cd docker-event-store
$ docker build -t eventstore .
```

### Running the image

You can run the image with the public http port mapped to your local machine and `log` and `db` folders mapped to your host machine.

```sh
$ docker run -t --rm -i -p 127.0.0.1:2113:2113 -v $(pwd)/db:/var/lib/eventstore -v $(pwd)/log:/var/log/eventstore eventstore
```

You can completely configure the environment with `ENV` vars. See [this document](http://docs.geteventstore.com/server/3.3.0/command-line-arguments/) for more info.

### Testing the build

You can start using the HTTP API:

```sh
$ curl -i -d @simple-event.txt -H "Content-Type:application/vnd.eventstore.events+json" "http://127.0.0.1:2113/streams/newstream"
$ curl -i -H "Accept:application/vnd.eventstore.atom+json" "http://127.0.0.1:2113/streams/newstream/0"
```

### TODO:

Add documentation about cluster deploys
