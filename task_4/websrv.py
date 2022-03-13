from aiohttp import web
import redis

data = {}

def get_name():
    r = redis.StrictRedis(host='192.168.4.117', port=6379, db=0)
    if r.get('name'):
        name = r.get('name').decode()
    else:
        name = r.get('name')
    return name

def set_name(name):
    r = redis.StrictRedis(host='192.168.4.117', port=6379, db=0)
    r.set('name', name)

async def getwelcome(request:web.Request):
    if not data.get('name'):
        if not get_name():
            data['name'] = "Wiredcraft"
        else:
            data['name'] = get_name()
    text = "Hello, {}!".format(data['name'])
    return web.Response(text=text)

async def putwelcome(request:web.Request):
    req = await request.json()
    for k, v in req.items():
        data[k] = v
    set_name(v)
    return web.json_response("{} success".format(req), status=201)

app = web.Application()

app.router.add_get('/welcome', getwelcome)
app.router.add_put('/welcome', putwelcome)

web.run_app(app, host='0.0.0.0', port=9999)