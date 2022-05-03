from flask import Flask
from flask import request
import os
app = Flask(__name__)


@app.route('/welcome', methods=["GET","PUT"])   #Use the route() decorator to bind a function to a URL.
def welcome():
    if request.method == 'GET':
        name = requests.args.get('name', '')      #Use "name" as a request
        connection = db.get_db()                      # connect to the database,select the name
        query = "SELECT * FROM userProfile WHERE name = {}".format(name)
        result = query_db(query,one=True)       # get a database's cursor
        if result is None:
            return 'Hello, Wiredcarft!'
        else:
            return f'Hello, {escape(name)}!'         # determine whether the user exists
    elif request.method == 'PUT':
        #Use "name" as a request
        name = request.json.get('name')          #Use "name" as a request
        connection = db.get_db()
        query = "UPDATE userProfile set name = {}".format(name)   
        connection.excute(query)
        connection.commit
        return {
            "name": name.name                          #return "name"  as aody
        }


if __name__=='__main__':
    os.mknod('../logs/docker.log')
    app.run(port=8888,debug=True,host='127.0.0.1')  # Create an APIserver



