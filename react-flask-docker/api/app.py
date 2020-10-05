from flask import Flask, jsonify, make_response


app = Flask(__name__)

@app.route('/api/v1/ping', methods=['GET'])
def ping():
    """Return ping status"""
    response = {
        'Status': 'OK'
    }

    response = make_response(jsonify(response))
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'

    return response
