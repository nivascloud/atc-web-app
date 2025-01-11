from flask import Flask, render_template
from prometheus_client import start_http_server, Summary

app = Flask(__name__)

# Create a metric to track the request duration
REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

@app.route('/')
def home():
    # Render an HTML page with static content
    return render_template('index.html')

@app.route('/metrics')
@REQUEST_TIME.time()  # Track time spent on this endpoint
def metrics():
    from prometheus_client import generate_latest
    response = generate_latest()
    return response, 200, {'Content-Type': 'text/plain; charset=utf-8'}

if __name__ == '__main__':
    # Start Prometheus client server on port 8000
    start_http_server(8000)
    # Run the web app on port 8080
    app.run(host="0.0.0.0", port=8080)