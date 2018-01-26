development env ```foreman start```

production env ```foreman start -f Procfile.prod```


#### For deploy starting (from ansible dir):
```ansible-playbook cars.yml -t deploy,passenger --extra-vars "env=staging" --ask-pass --ask-sudo-pass```
