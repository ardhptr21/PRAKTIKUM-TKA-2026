from flask import Flask
import redis
import os

app = Flask(__name__)

# Mengambil pengaturan dari file .env
db_host = os.getenv('DB_HOST')
db_port = os.getenv('DB_PORT')

# Koneksi ke Redis (Arkhe Core)
cache = redis.Redis(host=db_host, port=db_port)

@app.route('/')
def index():
    return "<h1>Fontaine Research Institute: Operational</h1>"

@app.route('/energy')
def energy():
    # Menambah angka energi di Redis setiap halaman di-refresh
    energy_level = cache.incr('arkhe_energy_level')
    return f"""
    <h1>Arkhe Energy Management</h1>
    <p>Current Energy Level: <b>{energy_level} Units</b></p>
    <p>Status: Pneuma/Ousia Balance Stable</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)