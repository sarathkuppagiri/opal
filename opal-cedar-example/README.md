# Cedar-Agent and Cedar

Cedar is an open-source engine and language created by AWS. Cedar agent is an OSS project from Permit.io - which provides the ability to run Cedar as a standalone agent (Similar to how one would use OPA) which can then be powered by OPAL. Cedar agent is the easiest way to deploy and run Cedar.

OPAL can run Cedar instead of OPA. To launch an example configuration with Docker-Compose, do:


```

docker-compose up
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

To show how the policy affects the request, set a policy with fewer permissions with a PUT on /policies:
localhost:8180/v1/policies

```

[
    {
        "id": "policy/writer.cedar",
        "content": "permit(\n  principal in Role::\"writer\",\n  action in [Action::\"post\",Action::\"put\"],\n  resource in ResourceType::\"article\"\n) when {\n  true\n};"
    },
    {
        "id": "policy/user.cedar",
        "content": "permit(\n  principal,\n  action in [Action::\"get\"],\n  resource\n) when {\n  true\n};"
    },
    {
        "id": "policy/admin.cedar",
        "content": "permit(\n  principal in Role::\"admin\",\n  action,\n  resource\n) when {\n  true\n};"
    }
]

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

Request :


{
    "principal": "User::\"writer@blog.app\"",
    "action": "Action::\"post\"",
    "resource": "ResourceType::\"article\""
}

Response :

{
    "decision": "Allow",
    "diagnostics": {
        "reason": [
            "policy/writer.cedar"
        ],
        "errors": []
    }
}

Request :


{
    "principal": "User::\"writer@blog.app\"",
    "action": "Action::\"put\"",
    "resource": "ResourceType::\"article\""
}

Response :

{
    "decision": "Allow",
    "diagnostics": {
        "reason": [
            "policy/writer.cedar"
        ],
        "errors": []
    }
}

Request :


{
    "principal": "User::\"writer@blog.app\"",
    "action": "Action::\"delete\"",
    "resource": "ResourceType::\"article\""
}

Response :

{
    "decision": "Deny",
    "diagnostics": {
        "reason": [],
        "errors": []
    }
}



```


