# -*- coding: utf-8 -*-
"""
    With jQuery Example
    ~~~~~~~~~~~~~~

    A GODPAPER-Go-Flask application that jQuery get prepared.

    :copyright: (c) 201u by z@smartkit.info.
    :license: SMARTKIT.INFO.
"""
from flask import Flask, jsonify, render_template, request
app = Flask(__name__)


@app.route('/_add_numbers')
def add_numbers():
    """Add two numbers server side, ridiculous but well..."""
    a = request.args.get('a', 0, type=int)
    b = request.args.get('b', 0, type=int)
    return jsonify(result=a + b)


@app.route('/jquery')
def jquery():
    return render_template('jquery.html')

@app.route("/demo")
def main():
    return render_template('demo1.html')

@app.route('/')
def info():
	return 'GODPAPER-Go-Flask Dockerized!'

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=80)
