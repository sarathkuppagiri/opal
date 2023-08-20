# OPAL Scopes

OPAL Scopes allows OPAL to serve different policies and data sources, serving them to multiple clients. Every scope contains its own policy and data sources. All clients using the same Scope ID will get the same policy and data.

Scopes are an easy way to use OPAL with multiple Git repositories (or other sources of policy), and are a core feature to enable using OPAL itself as a multi-tenant service.

Scopes are dynamic, and can be created on the fly through the scopes API (/scopes)

## Setting up scopes

### Use a REST API call to create or change a scope

In this scenario, we create two different scopes (test1 and test2). The test1 scope uses policies located in the test1 directory "https://github.com/sarathkuppagiri/opal-multi-policy-repo", and test2 uses policies defined in the default directory "https://github.com/sarathkuppagiri/opal-user-repo". We can set different directories, different branches, different repositories, and any other setting.

```

curl --location --request PUT 'localhost:7002/scopes' \
--header 'Content-Type: application/json' \
--data-raw '{
    "scope_id": "test1",
    "policy": {
        "source_type": "git",
        "url": "https://github.com/sarathkuppagiri/opal-multi-policy-repo",
        "auth": {
            "auth_type": "github_token",
            "token": "github_token"
        },
        "directories": [
            "test1"
        ],
        "extensions": [
            ".rego",
            ".json"
        ],
        "manifest": ".manifest",
        "poll_updates": true,
        "branch": "master"
    },
    "data": {
        "entries": []
    }
}'



curl --location --request PUT 'localhost:7002/scopes' \
--header 'Content-Type: application/json' \
--data-raw '{
    "scope_id": "test2",
    "policy": {
        "source_type": "git",
        "url": "https://github.com/sarathkuppagiri/opal-user-repo",
        "auth": {
            "auth_type": "github_token",
            "token": "github_token"
        },
        "directories": [
            "."
        ],
        "extensions": [
            ".rego",
            ".json"
        ],
        "manifest": ".manifest",
        "poll_updates": true,
        "branch": "master"
    },
    "data": {
        "entries": []
    }
}'


```

### Launch OPAL Clients with a scope

```

opal_client_test2:
    # by default we run opal-client from latest official image
    image: permitio/opal-client:latest
    environment:
      - OPAL_SERVER_URL=http://opal_server:7002
      - OPAL_LOG_FORMAT_INCLUDE_PID=true
      - OPAL_INLINE_OPA_LOG_FORMAT=http
      - OPAL_POLICY_SUBSCRIPTION_DIRS=test2

      # Uncomment the following lines to enable storing & loading OPA data from a backup file:
      # - OPAL_OFFLINE_MODE_ENABLED=true
    # volumes:
    #  - opa_backup:/opal/backup:rw

    ports:
      # exposes opal client on the host machine, you can access the client at: http://localhost:7766
      - "7767:7000"
      # exposes the OPA agent (being run by OPAL) on the host machine
      # you can access the OPA api that you know and love at: http://localhost:8181
      # OPA api docs are at: https://www.openpolicyagent.org/docs/latest/rest-api/
      - "8182:8181"
    depends_on:
      - opal_server
    # this command is not necessary when deploying OPAL for real, it is simply a trick for dev environments
    # to make sure that opal-server is already up before starting the client.
    command: sh -c "exec ./wait-for.sh opal_server:7002 --timeout=20 -- ./start.sh"

  opal_client_test3:
    # by default we run opal-client from latest official image
    image: permitio/opal-client:latest
    environment:
      - OPAL_SERVER_URL=http://opal_server:7002
      - OPAL_LOG_FORMAT_INCLUDE_PID=true
      - OPAL_INLINE_OPA_LOG_FORMAT=http
      - OPAL_POLICY_SUBSCRIPTION_DIRS=test3

      # Uncomment the following lines to enable storing & loading OPA data from a backup file:
      # - OPAL_OFFLINE_MODE_ENABLED=true
    # volumes:
    #  - opa_backup:/opal/backup:rw

    ports:
      # exposes opal client on the host machine, you can access the client at: http://localhost:7766
      - "7768:7000"
      # exposes the OPA agent (being run by OPAL) on the host machine
      # you can access the OPA api that you know and love at: http://localhost:8181
      # OPA api docs are at: https://www.openpolicyagent.org/docs/latest/rest-api/
      - "8183:8181"
    depends_on:
      - opal_server
    # this command is not necessary when deploying OPAL for real, it is simply a trick for dev environments
    # to make sure that opal-server is already up before starting the client.
    command: sh -c "exec ./wait-for.sh opal_server:7002 --timeout=20 -- ./start.sh"


```

### Running 

```

docker-compose up

```

The docker-compose.yml is running total 5 containers:

```

A Broadcast Channel Container
A Single OPAL Server Container
2 OPAL Client Containers (opal_client_test1, opal_client_test2)

opal_client_test1 is pointing to test1 scope
opal_client_test2 is pointing to test2 scope


```


### Client1

```

curl --location --request POST 'http://localhost:8181/v1/data/test1/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'

Response :

{
    "result": {
        "allow": [
            "account_api_authorized"
        ],
        "authorized": true,
        "deny": []
    }
}


```

### Client2

```

curl --location --request POST 'http://localhost:8182/v1/data/test/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'

Response :

{
    "result": {
        "allow": [
            "account_api_authorized"
        ],
        "authorized": true,
        "deny": []
    }
}

```