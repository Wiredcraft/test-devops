from flask import Flask, request, jsonify, session
import redis

app = Flask(__name__)
cache = redis.StrictRedis(host='redis', port=6379, db=0)

@app.route('/welcome', methods=["GET"])
def Get():
    name = request.args.get('name')
    if(name):
        return "Hello, " + name +"!"
    return "Hello, Wiredcraft!"

@app.route('/welcome', methods=["PUT"])
def Put():
    name = request.json.get("name")
    cache.set('name',name)
    return "Put Success"

