from flask import Flask, jsonify

app = Flask(__name__)

@app.get('/')
def home():
    return jsonify({
        "status": "ONLINE",
        "projeto": "AtomicPulse - Challenge Marinha 2026",
        "modulo": "DevOps Tools & Cloud Computing PoC",
        "mensagem": "API executada com sucesso em Container Docker dentro da Azure VM!"
    }), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)