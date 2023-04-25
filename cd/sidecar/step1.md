In this Application, component `log-gen-worker` and sidecar share the data volume that saves the logs.
The sidebar will re-output the log to stdout.

RUN `vela up -f /app.yaml`{{exec}}

Use `vela ls`{{exec}} to check the application state:

```shell
APP                 	COMPONENT     	TYPE       	TRAITS 	PHASE  	HEALTHY	STATUS	CREATED-TIME                 
vela-app-with-sidecar	log-gen-worker	worker     	sidecar           	running	healthy	      	2021-08-29 22:07:07 +0800 CST
```

And check the logging output of sidecar.

RUN `vela logs vela-app-with-sidecar --container count-log`{{exec}}
