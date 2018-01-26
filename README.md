development env ```foreman start```

production env ```foreman start -f Procfile.production```

staging env ```foreman start -f Procfile.staging```

#### For deploy starting (from ansible dir):
```ansible-playbook cars.yml -t deploy,passenger --extra-vars "env=staging" --ask-pass --ask-sudo-pass```
