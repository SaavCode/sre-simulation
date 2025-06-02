from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)  # Exposes /metrics

@app.route("/")
def home():
    return "SRE Flask App Running"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5069)