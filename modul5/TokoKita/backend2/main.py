from flask import Flask, jsonify, request
from socket import gethostname
import hashlib

app = Flask(__name__)


@app.route("/")
def home():
    return jsonify({"message": f"{gethostname()} - TokoKita"})


@app.route("/products")
@app.route("/catalogue")
def products():
    return jsonify(
        {
            "message": f"Daftar produk",
            "products": [
                {"id": 1, "name": "Laptop", "price": 12000000},
                {"id": 2, "name": "Mouse", "price": 150000},
                {"id": 3, "name": "Keyboard", "price": 350000},
            ],
        }
    )


@app.route("/checkout", methods=["POST"])
def checkout():
    payload = request.get_json(silent=True) or {}
    data = (
        f"{payload.get('user', 'guest')}:"
        f"{payload.get('product_id', 0)}:"
        f"{payload.get('quantity', 1)}"
    ).encode()

    ITERATIONS = 15000000

    for _ in range(ITERATIONS):
        data = hashlib.sha256(data).digest()

    return jsonify(
        {
            "message": "Checkout berhasil",
            "server": gethostname(),
        }
    )


app.run(host="0.0.0.0", port=5000)
