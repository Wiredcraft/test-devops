from flask import Flask, request, jsonify, session
import redis

app = Flask(__name__)

# Set redis config
cache = redis.StrictRedis(host='redis', port=6379, db=0)

# Get Method, if key(name) not exist, return "Hello, Wiredcraft!"
@app.route('/welcome', methods=["GET"])
def Get_Name():
    if(cache.get('name')):
        return "Hello, " + cache.get('name').decode() + "!"
    return "Hello, Wiredcraft!"

# Put Method, used to set key/value
@app.route('/welcome', methods=["PUT"])
def Put_Name():
    name = request.json.get("name")
    cache.set('name', name)
    return "Put Success, Name is " + name

