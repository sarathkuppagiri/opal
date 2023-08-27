# opal server security

```

ssh-keygen -q -t rsa -b 4096 -m pem -f opal_crypto_key -N ""
export OPAL_AUTH_PUBLIC_KEY=`cat opal_crypto_key.pub`
export OPAL_AUTH_PRIVATE_KEY=`cat opal_crypto_key | tr '\n' '_'`
export OPAL_AUTH_MASTER_TOKEN=`openssl rand -hex 16`

```

```
OPAL_AUTH_MASTER_TOKEN=4de87fb98f6b24ea372113613325083b

Send auth master token as bearer token to the below endpoint

curl --location --request POST 'http://localhost:7002/token' \
--header 'Authorization: bearer 4de87fb98f6b24ea372113613325083b' \
--header 'Content-Type: application/json' \
--data-raw '{
  "type": "client"
}'

Response :

{
    "token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2OTMxNjY5MzksImV4cCI6MTcyNDcwMjkzOSwiYXVkIjoiaHR0cHM6Ly9hcGkub3BhbC5hYy92MS8iLCJpc3MiOiJodHRwczovL29wYWwuYWMvIiwic3ViIjoiNjMzOGNjYjIzZTgzNDU0MGFlOTY1NmFlNDA2MDdlODEiLCJwZWVyX3R5cGUiOiJjbGllbnQifQ.gyZXWr_lrqf52vRsEyLK2G4y-yyDT2WunRqvL2bZTMu3i2Dmj8Gy_z0aRChKfd8cB7wPe_CAv2Z5sDNbhni-JBB4GGGLv69-jDkYFxpofJ7qT1Ip82EF_zsqPSGKhPabA8fM9RdvT5k1ACxR4uN52ovCW07Ok8silVaX6RFSCrK4H5_fwSDx6B5pQQ-blQEHs9c8rOtB-Hje-qOoZioWj3hP-w0oeP_VQMPus3k_efsoD3X5riiqDJXM2hCgBwlk59jHgCYN-r2HXzvkr7dpKVWNXLxrMTR5YEIhMxzmihQEoygsBe4JU_28lSvdCAkTOZ5yc9t1inDeHCiWitc424tPAnuglxkVg4BFH7wu18T7Q_a14PQxZl_iy0IPQP1twuEMPPIWWHZk7UGAWEbRMF9WWoTzjmTVH33caebdDd9Xihnl8jUKWFmqYTYOL4WqjDnItJtwVuOPuwnyVej-7OhmSLYCUwXAuIPA2HOSlJt24S-4bEewqq1cHkjqtuGgBmaf6qL3f5ZeERfxxmW6XcIqfhkSB2Dh-j8lcWshzMrEiCpU70ALi7elFrZGAu095xgRlCpm-LlQrEcsKcnUjrp725OcOYjglAzfheA-wR59kfVjIzwtp0a6pEYJn_dgR1hUw4nyoCxxtxHNK42X9MGiFt-OvfM_JOsbJU-blAw",
    "type": "bearer",
    "details": {
        "id": "6338ccb2-3e83-4540-ae96-56ae40607e81",
        "type": "client",
        "expired": "2024-08-26T20:08:59.429392",
        "claims": {
            "peer_type": "client"
        }
    }
}


curl --location --request GET 'http://localhost:7002/policy' \
--header 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2OTMxNjY5MzksImV4cCI6MTcyNDcwMjkzOSwiYXVkIjoiaHR0cHM6Ly9hcGkub3BhbC5hYy92MS8iLCJpc3MiOiJodHRwczovL29wYWwuYWMvIiwic3ViIjoiNjMzOGNjYjIzZTgzNDU0MGFlOTY1NmFlNDA2MDdlODEiLCJwZWVyX3R5cGUiOiJjbGllbnQifQ.gyZXWr_lrqf52vRsEyLK2G4y-yyDT2WunRqvL2bZTMu3i2Dmj8Gy_z0aRChKfd8cB7wPe_CAv2Z5sDNbhni-JBB4GGGLv69-jDkYFxpofJ7qT1Ip82EF_zsqPSGKhPabA8fM9RdvT5k1ACxR4uN52ovCW07Ok8silVaX6RFSCrK4H5_fwSDx6B5pQQ-blQEHs9c8rOtB-Hje-qOoZioWj3hP-w0oeP_VQMPus3k_efsoD3X5riiqDJXM2hCgBwlk59jHgCYN-r2HXzvkr7dpKVWNXLxrMTR5YEIhMxzmihQEoygsBe4JU_28lSvdCAkTOZ5yc9t1inDeHCiWitc424tPAnuglxkVg4BFH7wu18T7Q_a14PQxZl_iy0IPQP1twuEMPPIWWHZk7UGAWEbRMF9WWoTzjmTVH33caebdDd9Xihnl8jUKWFmqYTYOL4WqjDnItJtwVuOPuwnyVej-7OhmSLYCUwXAuIPA2HOSlJt24S-4bEewqq1cHkjqtuGgBmaf6qL3f5ZeERfxxmW6XcIqfhkSB2Dh-j8lcWshzMrEiCpU70ALi7elFrZGAu095xgRlCpm-LlQrEcsKcnUjrp725OcOYjglAzfheA-wR59kfVjIzwtp0a6pEYJn_dgR1hUw4nyoCxxtxHNK42X9MGiFt-OvfM_JOsbJU-blAw'

Response:

{
    "manifest": [
        "utils.rego",
        "rbac.rego",
        "data.json"
    ],
    "hash": "f10608f2d759f1982c1e0d9eb7048d771cea4f2f",
    "old_hash": null,
    "data_modules": [
        {
            "path": ".",
            "data": "{\n  \"users\": {\n    \"alice\": {\n      \"roles\": [\"admin\"],\n      \"location\": {\n        \"country\": \"US\",\n        \"ip\": \"8.8.8.8\"\n      }\n    },\n    \"bob\": {\n      \"roles\": [\"employee\", \"billing\"],\n      \"location\": {\n        \"country\": \"US\",\n        \"ip\": \"8.8.8.8\"\n      }\n    },\n     \"sunil\": {\n      \"roles\": [\"guest\"],\n      \"location\": {\n        \"country\": \"US\",\n        \"ip\": \"8.8.8.8\"\n      }\n    },\n    \"eve\": {\n      \"roles\": [\"customer\"],\n      \"location\": {\n        \"country\": \"US\",\n        \"ip\": \"8.8.8.8\"\n      }\n    }\n  },\n  \"role_permissions\": {\n    \"customer\": [\n      {\n        \"action\": \"read\",\n        \"type\": \"dog\"\n      },\n      {\n        \"action\": \"read\",\n        \"type\": \"cat\"\n      },\n      {\n        \"action\": \"adopt\",\n        \"type\": \"dog\"\n      },\n      {\n        \"action\": \"adopt\",\n        \"type\": \"cat\"\n      }\n    ],\n    \"employee\": [\n      {\n        \"action\": \"read\",\n        \"type\": \"dog\"\n      },\n      {\n        \"action\": \"read\",\n        \"type\": \"cat\"\n      },\n      {\n        \"action\": \"update\",\n        \"type\": \"dog\"\n      },\n      {\n        \"action\": \"update\",\n        \"type\": \"cat\"\n      }\n    ],\n    \"billing\": [\n      {\n        \"action\": \"read\",\n        \"type\": \"finance\"\n      },\n      {\n        \"action\": \"update\",\n        \"type\": \"finance\"\n      }\n    ],\n    \"guest\": [\n     {\n       \"action\": \"read\",\n       \"type\": \"cat\"\n     },\n     {\n       \"action\": \"read\",\n       \"type\": \"finance\"\n     }\n    ]\n  }\n}\n"
        }
    ],
    "policy_modules": [
        {
            "path": "rbac.rego",
            "package_name": "app.rbac",
            "rego": "# Role-based Access Control (RBAC)\n# --------------------------------\n#\n# This example defines an RBAC model for a Pet Store API. The Pet Store API allows\n# users to look at pets, adopt them, update their stats, and so on. The policy\n# controls which users can perform actions on which resources. The policy implements\n# a classic Role-based Access Control model where users are assigned to roles and\n# roles are granted the ability to perform some action(s) on some type of resource.\n#\n# This example shows how to:\n#\n#\t* Define an RBAC model in Rego that interprets role mappings represented in JSON.\n#\t* Iterate/search across JSON data structures (e.g., role mappings)\n#\n# For more information see:\n#\n#\t* Rego comparison to other systems: https://www.openpolicyagent.org/docs/latest/comparison-to-other-systems/\n#\t* Rego Iteration: https://www.openpolicyagent.org/docs/latest/#iteration\n\npackage app.rbac\n\n# import data.utils\n\n# By default, deny requests\ndefault allow = false\n\n# Allow admins to do anything\nallow {\n\tuser_is_admin\n}\n\n# Allow bob to do anything\n#allow {\n#\tinput.user == \"bob\"\n#}\n\n# you can ignore this rule, it's simply here to create a dependency\n# to another rego policy file, so we can demonstate how to work with\n# an explicit manifest file (force order of policy loading).\n#allow {\n#\tinput.matching_policy.grants\n#\tinput.roles\n#\tutils.hasPermission(input.matching_policy.grants, input.roles)\n#}\n\n# Allow the action if the user is granted permission to perform the action.\nallow {\n\t# Find permissions for the user.\n\tsome permission\n\tuser_is_granted[permission]\n\n\t# Check if the permission permits the action.\n\tinput.action == permission.action\n\tinput.type == permission.type\n\n\t# unless user location is outside US\n\tcountry := data.users[input.user].location.country\n\tcountry == \"US\"\n}\n\n# user_is_admin is true if...\nuser_is_admin {\n\t# for some `i`...\n\tsome i\n\n\t# \"admin\" is the `i`-th element in the user->role mappings for the identified user.\n\tdata.users[input.user].roles[i] == \"admin\"\n}\n\n# user_is_viewer is true if...\nuser_is_viewer {\n\t# for some `i`...\n\tsome i\n\n\t# \"viewer\" is the `i`-th element in the user->role mappings for the identified user.\n\tdata.users[input.user].roles[i] == \"viewer\"\n}\n\n# user_is_guest is true if...\nuser_is_guest {\n\t# for some `i`...\n\tsome i\n\n\t# \"guest\" is the `i`-th element in the user->role mappings for the identified user.\n\tdata.users[input.user].roles[i] == \"guest\"\n}\n\n\n# user_is_granted is a set of permissions for the user identified in the request.\n# The `permission` will be contained if the set `user_is_granted` for every...\nuser_is_granted[permission] {\n\tsome i, j\n\n\t# `role` assigned an element of the user_roles for this user...\n\trole := data.users[input.user].roles[i]\n\n\t# `permission` assigned a single permission from the permissions list for 'role'...\n\tpermission := data.role_permissions[role][j]\n}\n"
        },
        {
            "path": "utils.rego",
            "package_name": "utils",
            "rego": "package utils\nhasPermission(grants, roles) {\n\tgrants[_] == roles[_]\n}\n"
        }
    ],
    "deleted_files": null
}

```
