from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/api/v1/ping')
def ping():
    return jsonify('Alive!')


@app.route('/api/v1/fake', methods=['GET', 'POST'])
def fake():
    if request.method == 'GET':
        return jsonify({
            'player': 'Lil Boy',
            'actions': ['wake up', 'eat', 'sleep']
        })
    else:
        try:
            player = request.form['player']
            actions = request.form['actions']

            return jsonify({
                'player': player,
                'actions': actions
            })
        except:
            return jsonify({
                'player': 'unrecognized',
                'actions': []    
            })


if __name__ == '__main__':
    app.run(debug=True)
