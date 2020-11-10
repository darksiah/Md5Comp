from flask import Flask, render_template
from flask import jsonify
import json

app = Flask(__name__)

@app.route('/')
def princ():
    return render_template('index.html')

@app.route('/data')
def devolverData():
    f = open('static/data/data.json', )
    data=json.load(f)
    return jsonify(data)


if __name__ == '__main__':
    app.run(host= '0.0.0.0')
