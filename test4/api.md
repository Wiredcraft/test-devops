# Test4 API

**version**: *1.0.0*

## Name API

The API about Name

### Get name

Returns Hello, {name}! if not exist name then returns Hello, Wiredcraft!

**route:** `/welcome`

**method:** `GET`

**parameters:** 

| name | type | in   | required | description |
| ---- | ---- | ---- | -------- | ----------- |
| name | string | query | False | if not exist name then returns default name |



### Put name

Store name to redis

**route:** `/welcome`

**method:** `PUT`

**parameters:** 

| name | type | in   | required | description |
| ---- | ---- | ---- | -------- | ----------- |
| name | string | query | True | Required Name |




## schemas

### UnprocessableEntity

| name | type | required | description |
| ---- | ---- | -------- | ----------- |
| loc | array | False | the error's location as a list.  |
| msg | string | False | a computer-readable identifier of the error type. |
| type_ | string | False | a human readable explanation of the error. |
| ctx | object | False | an optional object which contains values required to render the error message. |


### getNameResponse

| name | type | required | description |
| ---- | ---- | -------- | ----------- |
| code | integer | False | Status code |
| msg | string | False | msg |


### putNameResponse

| name | type | required | description |
| ---- | ---- | -------- | ----------- |
| code | integer | False | Status code |
| msg | string | False | msg |
| data | array | True |  |


