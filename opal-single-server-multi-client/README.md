# opal installation guide

```

docker-compose up
```

The docker-compose.yml is running total 5 containers:

```

A Broadcast Channel Container
A Single OPAL Server Container
3 OPAL Client Containers (opal_client_test1, opal_client_test2, opal_client_test3)

opal_client_test1 is pointing to test1 directory in the https://github.com/sarathkuppagiri/opal-multi-policy-repo
opal_client_test2 is pointing to test2 directory in the https://github.com/sarathkuppagiri/opal-multi-policy-repo
opal_client_test3 is pointing to test3 directory in the https://github.com/sarathkuppagiri/opal-multi-policy-repo

```

The policy directories the client will subscribe to are specified by the environment variable OPAL_POLICY_SUBSCRIPTION_DIRS passed to the client. The default is "." meaning the root directory in the branch (i.e: essentially all .rego and data.json files in the branch). : is used by the environment variable parsing as a delimiter between directories.

```
OPAL_POLICY_SUBSCRIPTION_DIRS=. meaning the root directory in the branch
OPAL_POLICY_SUBSCRIPTION_DIRS=test1 meaning the test1 directory in the branch.
OPAL_POLICY_SUBSCRIPTION_DIRS=test2 meaning the test2 directory in the branch.
OPAL_POLICY_SUBSCRIPTION_DIRS=test3 meaning the test3 directory in the branch.

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

curl --location --request POST 'http://localhost:8181/v1/data/test2/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'

Response

{}

curl --location --request POST 'http://localhost:8181/v1/data/test3/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'

Response

{}

```

### Client2

```

curl --location --request POST 'http://localhost:8182/v1/data/test2/auth/account' \
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

curl --location --request POST 'http://localhost:8182/v1/data/test1/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'

Response :

{}

curl --location --request POST 'http://localhost:8182/v1/data/test3/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'

Response :

{}

```

### Client3

```

curl --location --request POST 'http://localhost:8183/v1/data/test3/auth/account' \
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


curl --location --request POST 'http://localhost:8183/v1/data/test1/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'

Response :

{}

curl --location --request POST 'http://localhost:8183/v1/data/test2/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'

Response :

{}


```
