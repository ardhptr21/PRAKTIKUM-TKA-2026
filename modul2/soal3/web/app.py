from flask import Flask
from mysql.connector import connect
import os
import time

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")

while True:
    try:
        db = connect(
            host=DB_HOST,
            port=DB_PORT,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS,
        )
        print("[+] connected to database", flush=True)
        break
    except Exception as e:
        print(f"[-] failed to connect to database: {e}", flush=True)
        print("[i] retrying in 5 seconds...", flush=True)
        time.sleep(5)


app = Flask(__name__)

@app.route("/")
def home():
    sql = "SELECT * FROM anggota ORDER BY RAND() LIMIT 1"
    cursor = db.cursor()
    cursor.execute(sql)
    nrp, nama = cursor.fetchone()
    return f"<h1>Nama Mahasiswa:</h1><h2>{nama}</h2><p>NRP: {nrp}</p>"