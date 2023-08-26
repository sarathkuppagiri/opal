# opal multi cedar agent with single repo

```

docker-compose up
```

The docker-compose.yml is running total 5 containers:

```

A Broadcast Channel Container
A Single OPAL Server Container
3 OPAL Client Containers (opal_client_policy1, opal_client_policy2, opal_client_policy3)

opal_client_policy1 is pointing to policy1 directory in the https://github.com/sarathkuppagiri/opal-multi-cedar-policy-repo
opal_client_policy2 is pointing to policy2 directory in the https://github.com/sarathkuppagiri/opal-multi-cedar-policy-repo
opal_client_policy3 is pointing to policy3 directory in the https://github.com/sarathkuppagiri/opal-multi-cedar-policy-repo

```

The policy directories the client will subscribe to are specified by the environment variable OPAL_POLICY_SUBSCRIPTION_DIRS passed to the client. The default is "." meaning the root directory in the branch (i.e: essentially all .rego and data.json files in the branch). : is used by the environment variable parsing as a delimiter between directories.

```
OPAL_POLICY_SUBSCRIPTION_DIRS=. meaning the root directory in the branch
OPAL_POLICY_SUBSCRIPTION_DIRS=policy1 meaning the policy1 directory in the branch.
OPAL_POLICY_SUBSCRIPTION_DIRS=policy2 meaning the policy2 directory in the branch.
OPAL_POLICY_SUBSCRIPTION_DIRS=policy3 meaning the policy3 directory in the branch.

```

### Client1

```

curl --location --request POST 'localhost:8180/v1/is_authorized' \
--header 'Content-Type: application/json' \
--data-raw '{
    "principal": "User::\"writer@blog.app\"",
    "action": "Action::\"post\"",
    "resource": "ResourceType::\"article\""
}'

Response :

{
    "decision": "Allow",
    "diagnostics": {
        "reason": [
            "policy1/writer.cedar"
        ],
        "errors": []
    }
}

```

### Client2

```

curl --location --request POST 'localhost:8181/v1/is_authorized' \
--header 'Content-Type: application/json' \
--data-raw '{
    "principal": "User::\"writer@blog.app\"",
    "action": "Action::\"post\"",
    "resource": "ResourceType::\"article\""
}'

Response :

{
    "decision": "Allow",
    "diagnostics": {
        "reason": [
            "policy2/writer.cedar"
        ],
        "errors": []
    }
}

```


### Client3

```

curl --location --request POST 'localhost:8182/v1/is_authorized' \
--header 'Content-Type: application/json' \
--data-raw '{
    "principal": "User::\"writer@blog.app\"",
    "action": "Action::\"post\"",
    "resource": "ResourceType::\"article\""
}'

Response :

{
    "decision": "Allow",
    "diagnostics": {
        "reason": [
            "policy3/writer.cedar"
        ],
        "errors": []
    }
}

```
