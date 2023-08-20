
### Spring security OPAL

curl --location --request POST 'http://localhost:8181/v1/data/test/auth/account' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "principal": "user1",
        "authorities": ["ROLE_account:read:0001"],
        "uri": "/account/0001"
    }
}'




## Run AccountControllerLiveTest testcase