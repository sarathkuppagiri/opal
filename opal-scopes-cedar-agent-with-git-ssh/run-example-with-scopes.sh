#!/bin/bash

set -e

if [ ! -f "docker-compose-scopes-example.yml" ]; then
   echo "did not find compose file - run this script from the 'docker/' directory under opal root!"
   exit
fi

echo "------------------------------------------------------------------"
echo "This script will run the docker-compose-scopes-example.yml example"
echo "configuration, and demonstrates how to correctly create scopes in OPAL server"
echo "------------------------------------------------------------------"

echo "Run OPAL server with scopes in the background"
docker compose -f docker-compose-scopes-example.yml up -d opal_server --remove-orphans

sleep 2

echo "Create scope 'myscope'"
curl --request PUT 'http://localhost:7002/scopes' --header 'Content-Type: application/json' --data-raw '{
  "scope_id": "myscope",
  "policy": {
    "source_type": "git",
    "url": "git@github.com:sarathkuppagiri/opal-multi-cedar-policy-repo.git",
   "auth": {
      "auth_type": "ssh",
      "username": "opal-test",
      "public_key" : "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPUF7mcoD4jnsvBSguPUALZj4J30vlHIyCKfoyEYS7T sarathkumarreddy@Saraths-MBP.lan",
     "private_key": "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACBD1Be5nKA+I57LwUoLj1AC2Y+Cd9L5RyMgin6MhGEu0wAAAKiFdz2YhXc9\nmAAAAAtzc2gtZWQyNTUxOQAAACBD1Be5nKA+I57LwUoLj1AC2Y+Cd9L5RyMgin6MhGEu0w\nAAAEBgqH+Fv6LGGSI3DQt2clDOpbqoYeEqVipbUNvBNRZHAkPUF7mcoD4jnsvBSguPUALZ\nj4J30vlHIyCKfoyEYS7TAAAAIHNhcmF0aGt1bWFycmVkZHlAU2FyYXRocy1NQlAubGFuAQ\nIDBAU=\n-----END OPENSSH PRIVATE KEY-----"
    },
    "directories": [
            "policy1"
    ],
    "extensions": [
      ".cedar",
      ".json"
    ],
    "manifest": ".manifest",
    "poll_updates": "true",
    "branch": "main"
  },
  "data": {
      "entries": [
         {
            "url": "http://opal-server:7002/policy-data",
            "dst_path": "",
            "topics" : ["policy_data"]
         }
      ]
   }
}'

echo "Create scope 'herscope'"
curl --request PUT 'http://localhost:7002/scopes' --header 'Content-Type: application/json' --data-raw '{
  "scope_id": "herscope",
  "policy": {
    "source_type": "git",
    "url": "git@github.com:sarathkuppagiri/opal-multi-cedar-policy-repo.git",
    "auth": {
      "auth_type": "ssh",
      "username": "opal-test",
       "public_key" : "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPUF7mcoD4jnsvBSguPUALZj4J30vlHIyCKfoyEYS7T sarathkumarreddy@Saraths-MBP.lan",
      "private_key": "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACBD1Be5nKA+I57LwUoLj1AC2Y+Cd9L5RyMgin6MhGEu0wAAAKiFdz2YhXc9\nmAAAAAtzc2gtZWQyNTUxOQAAACBD1Be5nKA+I57LwUoLj1AC2Y+Cd9L5RyMgin6MhGEu0w\nAAAEBgqH+Fv6LGGSI3DQt2clDOpbqoYeEqVipbUNvBNRZHAkPUF7mcoD4jnsvBSguPUALZ\nj4J30vlHIyCKfoyEYS7TAAAAIHNhcmF0aGt1bWFycmVkZHlAU2FyYXRocy1NQlAubGFuAQ\nIDBAU=\n-----END OPENSSH PRIVATE KEY-----"
    },
     "directories": [
            "policy2"
    ],
    "extensions": [
      ".cedar",
      ".json"
    ],
    "manifest": ".manifest",
    "poll_updates": true,
    "branch": "main"
  },
  "data": {
      "entries": [
         {
            "url": "http://opal-server:7002/policy-data",
            "dst_path": "",
            "topics" : ["policy_data"]
         }
      ]
   }
}'

echo "Bring up OPAL clients to use newly created scopes"
docker compose -f docker-compose-scopes-example.yml up
