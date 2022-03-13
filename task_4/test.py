import redis

r = redis.StrictRedis(host='192.168.4.117', port=6379, db=0)

r.set('foo', 'bar')

print(r.get('lll'))

data = {}
print(data.get('ddd'))