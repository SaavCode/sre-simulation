# 🧾 Incident Report: CPU Spike and Temporary Downtime

**Service:** Local Flask App  
**Environment:** Localhost (dev/test)  
**Date:** June 2, 2025  
**Monitored by:** Prometheus  
**Visualized in:** Grafana  
**Restarted by:** Supervisor  
**Detected at:** 2:10 PM  
**Resolved at:** 2:13 PM  
**Duration:** ~3 minutes  
**Severity:** Moderate  
**Status:** Resolved

---

## 🔍 Summary

The system experienced a temporary spike in CPU usage caused by a synthetic workload introduced to simulate high resource consumption. As the CPU load approached 100%, response times increased and the Flask app briefly became unresponsive. Monitoring captured the anomaly and displayed real-time metrics in Grafana. Prometheus metrics continued to scrape, confirming that the system recovered shortly afterward without requiring manual intervention.

---

## 📈 Detection

- **Prometheus Metric:** `node_cpu_seconds_total` (simulated local CPU stats)
- **Grafana Panel:** CPU usage line chart with `avg(rate(...))` expressions
- **Alert Status:** None configured for this test, but visualization showed redline activity

---

## 🛠️ Root Cause

CPU usage was artificially spiked using a `while True:` loop in a background thread to simulate stress. This caused the app’s responsiveness to degrade temporarily, but no long-term failure occurred.

---

## 🔁 Response

1. Grafana dashboard displayed real-time CPU spike.
2. Application became sluggish but did not crash.
3. Supervisor ensured process did not exit.
4. After stressor was killed, system returned to normal operating state.

---

## ✅ Resolution Steps

- Manually terminated CPU-intensive process.
- Monitored system metrics to confirm normalization.
- Verified Flask app responded to `/metrics` endpoint again.

---

## 🧠 Lessons Learned

- CPU saturation directly impacts app responsiveness even without triggering a crash.
- Prometheus visualization can reveal performance degradation even without explicit alerts.
- Continuous monitoring provides valuable early warning before full outages occur.

---

## 🔄 Recommendations

- Implement alert rules for high CPU usage over sustained periods.
- Integrate process-level metrics into dashboards (e.g., `process_cpu_seconds_total`).
- Test other failure modes (e.g., memory exhaustion, disk full).
