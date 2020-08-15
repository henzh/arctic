from flask import Flask

app = Flask(__name__)


@app.route('/')
def home():
    return 'Piepie home!'


@app.route('/ping')
def ping():
    return 'Piepie is healthy!'
