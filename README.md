development - ```APP_ENV=development passenger start -R app.ru --pid-file ./tmp/pids/passenger.pid --log-file ./logs/passenger.log --log-level 5```

production - ```APP_ENV=production passenger start -R app.ru --pid-file ./tmp/pids/passenger.pid --log-file ./logs/passenger.log -e production```