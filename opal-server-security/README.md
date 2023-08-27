# opal installation guide

```

docker-compose up
```

The docker-compose.yml is running 3 containers:

```

A Broadcast Channel Container
An OPAL Server Container
An OPAL Client Container
```

OPAL (and also OPA) are now running on your machine. You should be aware of the following ports that are exposed on localhost:

```

OPAL Server - PORT :7002 - the OPAL client (and potentially the CLI) can connect to this port.
OPAL Client - PORT :7766 - the OPAL client has its own API, but it's irrelevant to this tutorial.
OPA - PORT :8181 - the port of the OPA Agent that is running running in server mode.

```
Configure git repo policy in the opal server as below

```
      - OPAL_POLICY_REPO_URL=git@github.com:sarathkuppagiri/opal-user-repo.git
      - OPAL_POLICY_REPO_MAIN_BRANCH=main
      - OPAL_POLICY_REPO_SSH_KEY=-----BEGIN OPENSSH PRIVATE KEY-----_b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW_QyNTUxOQAAACBD1Be5nKA+I57LwUoLj1AC2Y+Cd9L5RyMgin6MhGEu0wAAAKiFdz2YhXc9_mAAAAAtzc2gtZWQyNTUxOQAAACBD1Be5nKA+I57LwUoLj1AC2Y+Cd9L5RyMgin6MhGEu0w_AAAEBgqH+Fv6LGGSI3DQt2clDOpbqoYeEqVipbUNvBNRZHAkPUF7mcoD4jnsvBSguPUALZ_j4J30vlHIyCKfoyEYS7TAAAAIHNhcmF0aGt1bWFycmVkZHlAU2FyYXRocy1NQlAubGFuAQ_IDBAU=_-----END OPENSSH PRIVATE KEY-----
```


