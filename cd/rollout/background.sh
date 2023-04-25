#!/bin/bash

set -x # to test stderr output in /var/log/killercoda

echo starting... # to test stdout output in /var/log/killercoda

# sleep 5 # some long running background task

# touch /tmp/kubevela

cat <<EOF >> /canary-demo-v1.yaml
apiVersion: core.oam.dev/v1beta1
kind: Application
metadata:
   name: canary-demo
   annotations:
      app.oam.dev/publishVersion: v1
spec:
   components:
      - name: canary-demo
        type: webservice
        properties:
           image: wangyikewyk/canarydemo:v1
           ports:
              - port: 8090
        traits:
           - type: scaler
             properties:
                replicas: 5
           - type: gateway
             properties:
                domain: canary-demo.com
                http:
                   "/version": 8090
EOF

cat <<EOF >> /canary-demo-v2.yaml
apiVersion: core.oam.dev/v1beta1
kind: Application
metadata:
   name: canary-demo
   annotations:
      app.oam.dev/publishVersion: v2
spec:
   components:
      - name: canary-demo
        type: webservice
        properties:
           image: wangyikewyk/canarydemo:v2
           ports:
              - port: 8090
        traits:
           - type: scaler
             properties:
                replicas: 5
           - type: gateway
             properties:
                domain: canary-demo.com
                http:
                   "/version": 8090
   workflow:
      steps:
         - type: canary-deploy
           name: rollout-20
           properties:
              weight: 20
         - name: suspend-1st
           type: suspend
         - type: canary-deploy
           name: rollout-50
           properties:
              weight: 50
         - name: suspend-2nd
           type: suspend
         - type: canary-deploy
           name: rollout-100
           properties:
              weight: 100
EOF