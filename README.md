development env ```foreman start```

production env ```foreman start -f Procfile.prod```

```ansible-playbook nap_cars.yml -t deploy,passenger,delayed_job --extra-vars "env=staging" --ask-pass --ask-sudo-pass```
