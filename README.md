# QoS-driven scheduling experiments

This repository contains the input data used in the experiments described in the paper submitted to "ACM Transactions on Computer Systems" and instructions about how to proceed to run the simulation and measurement experiments using simulators and .

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

In the case of synthetic workloads, they were submitted to the simulators and the kubernetes system. In order to automate the execution of measurements experiments on kubernetes, we have developed a application that submits requests to kubernetes based on a workload description file. Although the content of the files used is essentially the same for both experiments, there are some differences in the format of the files. A workload file submitted to this broker contains the following fields:
1. *time passed from the begin of the experiment* (admission time of the task)
2. *task id*
3. *job id*
4. *user (?)*
5. *task priority*
6. ...


## infrastructure
infrastructure format

# how to access the code of simulator and 


repository (link)

# how to run the PoC

repository (link)
[I'm an inline-style link](https://www.google.com)

The prototype was developed on top of Kubernetes version 9. If you 
experiment image version for prometheus, kube-wtach and scheduler:
