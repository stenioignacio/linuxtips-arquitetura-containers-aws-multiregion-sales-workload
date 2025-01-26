#!/bin/bash
set noglob

mkdir -p {deployment,post-deployment,pre-deployment}/environment
mkdir -p deployment/environment/{us-east-1,sa-east-1}

touch {pre,post}-deployment/environment/{backend,terraform}.tfvars
touch deployment/environment/{us-east-1,sa-east-1}/{terraform,backend}.tfvars

touch {deployment,post-deployment,pre-deployment}/{variables,backend,output,providers,data}.tf
