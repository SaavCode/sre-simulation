# 🛠️ Site Reliability Engineering Simulation

## 📌 Purpose

This simulation was designed to emulate a real-world Site Reliability Engineer (SRE) workflow focused on observability, alerting, incident recovery, and automation. Inspired by the Valigator job description, it aimed to showcase proactive monitoring and reliability on a bare-metal-style local setup.

---

## ✅ Requirements Covered

* Alerting systems based on symptoms
* Automated recovery workflows
* Monitoring and observability
* Root cause analysis through simulated failure
* Familiarity with Linux, Python, and configuration management
* Hands-on system ownership with self-healing setups
* Flask app exposing `/metrics`
* Prometheus installed and configured for local scraping
* Grafana installed and set up for dashboarding and alerting
* Supervisor installed for process monitoring and restart
* `prometheus_flask_exporter` Python package
* `supervisor` Python package
* Python 3.8 environment set up with `pyenv`

---

## ⚙️ Tools Used and Why

| Tool           | Purpose                                                            |
| -------------- | ------------------------------------------------------------------ |
| **Flask**      | Lightweight Python web app to expose metrics for observability     |
| **Prometheus** | Monitors the app and scrapes `/metrics` data                       |
| **Grafana**    | Visualizes Prometheus metrics and sets up alert rules              |
| **Supervisor** | Automatically restarts the Flask app if it fails (process manager) |
| **Linux CLI**  | Used to manage processes, check ports, and view logs               |
| **lsof/kill**  | Debugging tools to resolve port conflicts and PID usage            |

---

## 🧪 Steps Followed

### Day 1 – Monitoring and Alerting

1. **Built a Flask App**

   * Exposed metrics using `prometheus_flask_exporter`
   * Hosted on port `5009`

2. **Installed Prometheus**

   * Edited `prometheus.yml`:

     ```yaml
     global:
       scrape_interval: 15s

     scrape_configs:
       - job_name: 'flask_app'
         static_configs:
           - targets: ['localhost:5009']
     ```
   * Started Prometheus and confirmed it scraped the Flask endpoint

3. **Installed Grafana**

   * Logged in with default `admin/admin`
   * Added **Prometheus** as a data source: `http://localhost:9090`
   * Created a **Dashboard** > **Add New Panel**

     * Query: `up{job="flask_app"}`
     * Visualization: Time Series or Table

4. **Created Alerts in Grafana**

   * In the same panel, went to **Alert** tab
   * Configured:

     * Alert condition: When `up` is **below 1**
     * Evaluation interval: `1m`
     * Set notification channel (if needed)
     * Named and saved the alert rule
   * Simulated failure by killing Flask app
   * Verified alert fired and resolved once app was restarted

---

### Day 2 – Auto-Recovery and Incident Simulation

5. **Installed and Configured Supervisor**

   * Created `supervisord.conf`:

     ```ini
     [supervisord]
     logfile=/tmp/supervisord.log
     pidfile=/tmp/supervisord.pid
     childlogdir=/tmp/
     serverurl=unix:///tmp/supervisor.sock

     [program:flask_app]
     command=python3 /Users/sreTest/app.py
     autostart=true
     autorestart=true
     stderr_logfile=/tmp/flask_err.log
     stdout_logfile=/tmp/flask_out.log

     [supervisorctl]
     serverurl=unix:///tmp/supervisor.sock
     ```
   * Ran:

     ```bash
     supervisord -c supervisord.conf
     supervisorctl -c supervisord.conf status
     ```
   * Supervisor successfully auto-restarted Flask app on crash

6. **Simulated Failures**

   * Manually killed Flask
   * Supervisor restarted it automatically
   * Observed alert in Grafana, then resolution once app was back

7. **Debugged Common Issues**

   * Addressed port conflicts
   * Cleared leftover socket/pid/log files
   * Used `supervisord.log`, `lsof`, and `kill` to diagnose problems

---

## 📊 Results

* Successful simulation of real-world observability and recovery
* Validated full alert → crash → auto-recover → alert resolve flow
* Verified logs and metrics throughout

---

## ✅ Summary

This project replicated the responsibilities of an entry-level SRE by setting up real-time monitoring, creating actionable alerts, and implementing a self-healing process. The stack used (Flask, Prometheus, Grafana, Supervisor) closely resembles infrastructure at blockchain companies like Valigator.

Through hands-on system setup and incident testing, this exercise demonstrated readiness to own, monitor, and stabilize production systems — with minimal dependencies and full Linux terminal workflow.

