# User module

This module is reponsible for providing a simple blog platform for Feather CMS.



```script
# login 
curl \
-X POST \
-H 'Content-Type: application/json' \
-d '{"email": "root@feathercms.com", "password": "FeatherCMS"}' \
"http://localhost:8080/api/login/" | jq


curl \
-X POST \
-H 'Authorization: Bearer QGTW8FAqeK8kRPSoKyIxmlBg8FHJ7hE60zjpiXW3veIKMTg7d6YUYDjAwtfRDMuz' \
-H 'Content-Type: application/json' \
-d '{"name": "lol"}' \
"http://localhost:8080/api/user/roles/" | jq


curl \
-X POST \
-H 'Authorization: Bearer jTFf4HJ7pxt4fUvLenzWFn7122FaYimI1f1ZZ96eX3I71aQZYr49LZrhbRP37uX4' \
-H 'Content-Type: application/json' \
-d '{"email": "elek@testlocalhost.com"}' \
"http://localhost:8080/api/user/invitations/" | json_pp




# get account details (profile only)
curl \
-X GET \
-H 'Authorization: Bearer QGTW8FAqeK8kRPSoKyIxmlBg8FHJ7hE60zjpiXW3veIKMTg7d6YUYDjAwtfRDMuz' \
-H 'Content-Type: application/json' \
"http://localhost:8080/api/profile/" | jq


# send reset password email
echo '{
    "email": "root@feathercms.com",
}'| curl -X POST "http://localhost:8080/api/reset-password/" \
-H 'Content-Type: application/json' \
-d @- | jq


# set new password using token
echo '{
    "token": "u1Vb4Uq7ZNaIMVaY8f8WaESsHEzCuldygrheMb0R1CSK1xfYWtDmSnvm88a5LR3O",
    "password": "ChangeMe1"
}'| curl -X POST "http://localhost:8080/api/new-password/" \
-H 'Content-Type: application/json' \
-d @- | jq

    


curl \
    -X POST "http://localhost:8080/api/admin/system/variables/" \
    -H 'Authorization: Bearer 6pH99KwlBbxwFwEB4F3oJPTHzGWsTgfNvPkanbF3hHPTv7tjQLQinRU3uJQesODg' \
    -H 'Content-Type: application/json' \
    -d ' \
    {\
        "name": "486B0B47-9785-43C9-B52C-AABC5D77718D"
    }' | jq
```
