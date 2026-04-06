import os
import json
from datetime import datetime
from flask import Flask, request, jsonify
import redis

app = Flask(__name__)

REDIS_HOST = os.environ.get('REDIS_HOST', 'arkhe-core')
REDIS_PORT = int(os.environ.get('REDIS_PORT', 6379))
PORT = int(os.environ.get('PORT', 8000))

client = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)


# Root route
@app.route('/', methods=['GET'])
def index():
    return jsonify({
        'status': 'stable',
        'message': 'Arkhe Energy System is online.',
        'system': 'Fontaine Energy Grid',
        'endpoints': {
            'root': 'GET /',
            'energy': 'GET /energy',
            'store': 'POST /energy'
        }
    })


# GET /energy — tampilkan semua data energi
@app.route('/energy', methods=['GET'])
def get_energy():
    try:
        keys = client.keys('energy:*')
        data = {}

        for key in keys:
            value = client.get(key)
            data[key] = json.loads(value)

        total_ousia = sum(e.get('ousia', 0) for e in data.values())
        total_pneuma = sum(e.get('pneuma', 0) for e in data.values())

        return jsonify({
            'status': 'stable',
            'total_entries': len(keys),
            'total_ousia': total_ousia,
            'total_pneuma': total_pneuma,
            'energy_records': data
        })
    except Exception as e:
        return jsonify({'error': 'Failed to retrieve energy data', 'detail': str(e)}), 500


# POST /energy — simpan data energi baru
@app.route('/energy', methods=['POST'])
def post_energy():
    try:
        body = request.get_json()

        if not body or 'id' not in body:
            return jsonify({'error': 'Energy ID is required.'}), 400

        energy_id = body['id']
        ousia = body.get('ousia', 0)
        pneuma = body.get('pneuma', 0)
        source = body.get('source', 'unknown')

        key = f'energy:{energy_id}'
        record = {
            'id': energy_id,
            'ousia': ousia,
            'pneuma': pneuma,
            'source': source,
            'timestamp': datetime.utcnow().isoformat()
        }

        client.set(key, json.dumps(record))

        return jsonify({
            'status': 'stored',
            'message': f"Energy record '{energy_id}' has been stored in Arkhe Core.",
            'record': record
        }), 201
    except Exception as e:
        return jsonify({'error': 'Failed to store energy data', 'detail': str(e)}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT)