# Cedar-Agent with OPAL scopes

Cedar is an open-source engine and language created by AWS. Cedar agent is an OSS project from Permit.io - which provides the ability to run Cedar as a standalone agent (Similar to how one would use OPA) which can then be powered by OPAL. Cedar agent is the easiest way to deploy and run Cedar.

OPAL can run Cedar instead of OPA. To launch an example configuration with Docker-Compose, do:


```

sh run-example-with-scopes.sh

```


You'll then have Cedar's dev web interface at http://localhost:8180/rapidoc/, where you can call Cedar-Agent's API routes.

You can show data with GET on /data, policy with GET on /policies, and you can POST the following authorization to /is_authorized request to perform an authorization check:
localhost:8180/v1/policies


```

{
    "principal": "User::\"admin@blog.app\"",
    "action": "Action::\"post\"",
    "resource": "Resource::\"article\""
}

```


## Testing

```
curl --location --request POST 'localhost:8180/v1/is_authorized' \
--header 'Content-Type: application/json' \
--data-raw '{
    "principal": "User::\"admin@blog.app\"",
    "action": "Action::\"post\"",
    "resource": "Resource::\"article\""
}'

Response :

{
    "decision": "Allow",
    "diagnostics": {
        "reason": [
            "policy/admin.cedar"
        ],
        "errors": []
    }
}

curl --location --request POST 'localhost:8181/v1/is_authorized' \
--header 'Content-Type: application/json' \
--data-raw '{
    "principal": "User::\"admin@blog.app\"",
    "action": "Action::\"post\"",
    "resource": "Resource::\"article\""
}'

Response :

{
    "decision": "Allow",
    "diagnostics": {
        "reason": [
            "policy/admin.cedar"
        ],
        "errors": []
    }
}


```


