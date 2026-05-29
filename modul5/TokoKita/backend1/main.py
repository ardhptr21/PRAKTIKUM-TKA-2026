from flask import Flask, jsonify
from socket import gethostname

app = Flask(__name__)


@app.route("/")
def home():
    return jsonify({"message": f"{gethostname()} - TokoKita"})


@app.route("/products")
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


app.run(host="0.0.0.0", port=5000)
