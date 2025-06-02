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
