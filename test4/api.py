from typing import List, Dict

import os
import redis
from flask_caching import Cache
from flask_openapi3 import OpenAPI, Info, Tag
from pydantic import BaseModel, Field

# Use redis to store data
# Use flask-caching for local cache
port = os.getenv('PORT', default='5000')
redis_host = os.getenv('REDIS_HOST', default='192.168.1.137')
info = Info(title='Test4 API', version='1.0.0')
app = OpenAPI(__name__, info=info)
tag = Tag(name='Name API', description="The API about Name")
database = redis.StrictRedis(host=redis_host, port=6379, db=0)
config = {
    "CACHE_TYPE": "SimpleCache",  # Flask-Caching related configs
    "CACHE_DEFAULT_TIMEOUT": 300
}
app.config.from_mapping(config)
cache = Cache(app)


class getName(BaseModel):
    # Name have a default value
    name: str = Field('Wirecraft', description='if not exist name then returns default name')


class putName(BaseModel):
    name: str = Field(..., description='Required Name')


class getNameResponse(BaseModel):
    code: int = Field(0, description='Status code')
    msg: str = Field("Hello <name:str>", description='msg')


class putNameResponse(BaseModel):
    code: int = Field(0, description='Status code')
    msg: str = Field("Got it!", description='msg')
    data: List[Dict['str', str]]


@app.get('/welcome',
         summary='Get name',
         description=r'Returns Hello, {name}! if not exist name then returns Hello, Wiredcraft!',
         responses={"200": getNameResponse},
         tags=[tag])
# query: Receive flask request.args
def get_name(query: getName):
    # If local cache have 'name',query it from local cache
    if cache.get('name'):
        query.name = cache.get('name')
    # If redis have 'name', get it and store it to local cache
    elif database.get('name'):
        cache.set('name', database.get('name').decode())
        query.name = cache.get('name')

    # If neither redis nor local cache have 'name', return the default value
    return {
        "code": 0,
        "message": f"Hello, {query.name}!",
        "data": []
    }


@app.put('/welcome',
         summary='Put name',
         description='Store name to redis',
         responses={"200": putNameResponse},
         tags=[tag])
# body: Receive flask request.json
def put_name(body: putName):
    # Get name from request body, then store it to redis and local cache
    name = body.name
    database.set('name', name)
    cache.set('name', name)
    return {
        "code": 0,
        "msg": "Got it!",
        "data": [{'name': name}]
    }


if __name__ == '__main__':
    app.run(port=int(port))
