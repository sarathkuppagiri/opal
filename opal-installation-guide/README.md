# opal installation guide

docker-compose up

The docker-compose.yml is running 3 containers:

A Broadcast Channel Container
An OPAL Server Container
An OPAL Client Container

OPAL (and also OPA) are now running on your machine. You should be aware of the following ports that are exposed on localhost:

OPAL Server - PORT :7002 - the OPAL client (and potentially the CLI) can connect to this port.
OPAL Client - PORT :7766 - the OPAL client has its own API, but it's irrelevant to this tutorial.
OPA - PORT :8181 - the port of the OPA Agent that is running running in server mode.


