#!/usr/bin/env python
# -*- coding:utf-8 -*-

from flask import Flask, jsonify

app = Flask(__name__)


@app.route('/wiredcraft/api/v1.0/mock_test', methods=['GET'])
def mock_test():
    return jsonify({"mock_test": "success"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8100, debug=True)