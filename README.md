development env ```foreman start```

production env ```foreman start -f Procfile.production```

staging env ```foreman start -f Procfile.staging```

#### For env bootstraping (from ansible dir):
```ansible-playbook cars.yml --extra-vars "env=staging" --ask-pass --ask-sudo-pass```
#### For deploy starting (from ansible dir):
```ansible-playbook cars.yml -t deploy,passenger --extra-vars "env=staging" --ask-pass --ask-sudo-pass```
