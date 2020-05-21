#!/bin/bash

kubectl apply --filename $(dirname ${0})/../manifests/k8s-exampleapp.yaml
