# QoS-driven scheduling experiments

This repository contains the input data used in the experiments described in the paper submitted to "ACM Transactions on Computer Systems" and instructions about how to proceed to run the simulation and measurement experiments.

# Input data

## workload

This repository contains all workloads used in the experiments of the "QoS-driven scheduling in the cloud" paper: google samples and synthetic workloads for validation. The google samples were submitted only to simulators. A workload file submitted to the simulators contains the following fields: 
1. *timestamp* (admission time of the task)
2. *task id*
3. *job id*
4. *task duration*
5. *cpu requested*
6. *ram requested*
7. *task priority*
8. *anti-affinity constraint* (the value 1 indicates that the specific job is anti-affinity constrained, which means that no more than one task of this job can be allocated in the same host)
9. *a list of placement constraints*

In the case of synthetic workloads, they were submitted to the simulators and the kubernetes system. In order to automate the execution of measurement experiments on kubernetes, we have developed an application (called as broker) that submits requests to kubernetes based on a workload description file. Although the content of the files used is essentially the same for both experiments, there are some differences in the format of the files. A workload file submitted to the broker contains the following fields:
1. *time passed from the begin of the experiment* (admission time of the task)
2. *task id*
3. *job id*
4. *user*
5. *anti-affinity constraint*
6. *task priority*
7. *task duration*
8. *cpu requested*
9. *ram requested*
10. *task class name*
11. *QoS target* (promised availability)

The broker, as well as the instructions on how to use it, are available at the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments)). Besides, the same repository has instructions about how to deploy a kubernetes cluster using the QoS-driven scheduler and how to understand the result files of a measurement experiment. 

## infrastructure

This repository also contains all infrastructure used in the experiments of the "QoS-driven scheduling in the cloud" paper. A infrastructure file used as input of the simulators contains the following fields: 
1. *host id*
2. *host name*
3. *cpu capacity*
4. *ram capacity*
5. *a list of attributes* (key=value format)

In the case of the measurement experiments, the infrastructure is formed by adding nodes into the kubernetes cluster. Please, find in the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments)) instructions about how to deploy a kubernetes cluster using the QoS-driven scheduler and how to understand the result files of a measurement experiment.

# Simulator 

repository (link)

# QoS-driven scheduler (prototype implementation for kubernetes)

We have implemented a proof-of-concept of the QoS-driven scheduler for the popular kubernetes system. In the kubernetes ecosystem, the instances are represented by pods that are associated with a deployment controller. In this study, we have considered the relation 1-to-1 between a deployment and a pod. In other words, all deployments must keep one pod running. Basically, two components were modified from the original kubernetes code: Cloudish queue and Cloudish scheduler. The former keeps the pods in the pending queue according to TTV values, while the latter implements the QoS-driven scheduler as described in the paper. Our QoS-diven scheduler implementation is available at repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments)).

In order to support QoS-driven scheduler execution, we have used two applications: prometheus and kube-watch. The prometheus 


Prometheus

kube-watch application

Instructions...

repository (link)
[I'm an inline-style link](https://www.google.com)

The prototype was developed on top of Kubernetes version 9. If you 
experiment image version for prometheus, kube-wtach and scheduler:
