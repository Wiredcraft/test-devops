import flask

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    return "<h1> Hello From Jerry</h1>"

if __name == '__main__':
    app.run(debug=True, host='0.0.0.0')