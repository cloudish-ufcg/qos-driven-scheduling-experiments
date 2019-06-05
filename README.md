# QoS-driven scheduling experiments

This repository contains the input data used in the experiments described in the paper submitted to "ACM Transactions on Computer Systems" and instructions about how to proceed to run the simulation and measurement experiments.

# Input data

## workload

This repository contains all workloads used in the experiments of the "QoS-driven scheduling in the cloud" paper: google samples and synthetic workloads for validation. The google samples were submitted only to simulator. A workload file submitted to the simulator contains the following fields: 
1. *timestamp* (admission time of the task)
2. *task id*
3. *job id*
4. *task duration*
5. *cpu requested*
6. *ram requested*
7. *task priority*
8. *anti-affinity constraint* (the value 1 indicates that the specific job is anti-affinity constrained, which means that no more than one task of this job can be allocated in the same host)
9. *a list of placement constraints*

In the case of synthetic workloads, they were submitted to the simulator and the kubernetes system. In order to automate the execution of measurement experiments on kubernetes, we have developed an application (called as broker) that submits requests to kubernetes based on a workload description file. Although the content of the files used is essentially the same for both experiments, there are some differences in the format of the files. A workload file submitted to the broker contains the following fields:
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

The broker, as well as the instructions on how to use it, are available at the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments-journal-paper)). Besides, the same repository has instructions about how to deploy a kubernetes cluster using the QoS-driven scheduler, how to submit a workload using the broker and how to understand the result files of a measurement experiment. 

## infrastructure

This repository also contains all infrastructure used in the experiments of the "QoS-driven scheduling in the cloud" paper. A infrastructure file used as input of the simulator contains the following fields: 
1. *host id*
2. *host name*
3. *cpu capacity*
4. *ram capacity*
5. *a list of attributes* (key=value format)

In the case of the measurement experiments, the infrastructure is formed by adding nodes into the kubernetes cluster. Please, find in the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments-journal-paper)) instructions about how to deploy a kubernetes cluster using the QoS-driven scheduler, how to submit a workload using the broker and how to understand the result files of a measurement experiment.

# Simulator 

We have implemented the simulator able to emulate both scheduling policies: priority-based and QoS-driven. Our simulator was developed in Erlang on top of the [Sim-diasca simulation framework](http://sim-diasca.com) and it is available at repository ([link](https://forge.ericsson.net/plugins/git/ufcg-er/cloudish?a=tree&hb=experiments-journal-paper)). In order to run a simulation test, you need to go into cloudish directory and run the following command:

`bash run_simulation.sh $SIM_DURATION $SCHEDULING_POLICY $WORKLOAD_FILE $INFRASTRUCTURE_FILE 3 $SAFTEY_MARGIN $PERIODICITY false $PREEMPTION_OVERHEAD_FILE $MIGRATION_OVERHEAD_FILE 1 $LIMITING_PREEMPTION $EXTRA_OVERHEAD`

where,
- *SIM_DURATION* is the duration of the simulation test in seconds;
- *SCHEDULING_POLICY* is the scheduling policy to be simulated {ttv | priority};
- *WORKLOAD_FILE* is the name of the workload file description that should be located in the data directory;
- *INFRASTRUCTURE_FILE* is the name of the infrastructure file description that should be located in the data directory;
- *SAFTEY_MARGIN* is the safety margin in seconds to be considered while the the QoS-driven scheduler is making decisions; 
- *PERIODICITY* is the maximum time between two sequential processing of the pending queue;
- *PREEMPTION_OVERHEAD_FILE* is the name of the file with a set of preemption overhead values to be considered when an instance is allocated in the same host that it was previously allocated. This file should be located in the data directory;
- *MIGRATION_OVERHEAD_FILE* is the name of the file with a set of migration overhead values to be considered when an instance is allocated in a host different whose it was previously allocated. This file should be located in the data directory;
- *LIMITING_PREEMPTION* is the flag that indicates if the mechanism to limit the number of preemption should be used {true | false};
- *EXTRA_OVERHEAD* indicates a extra value to be incremented to 1-SLO to be considered as the maximum overhead of preemption. For instance, 0 indicates that the limit of overhead is set to 1-slo.

# QoS-driven scheduler (prototype implementation for kubernetes)

We have implemented a proof-of-concept of the QoS-driven scheduler for the popular kubernetes system. In the kubernetes ecosystem, the instances are represented by pods that are associated with a deployment controller. In this study, we have considered the relation 1-to-1 between a deployment and a pod. In other words, all deployments must keep one pod running. Basically, two components were modified from the original kubernetes code: Cloudish queue and Cloudish scheduler. The former keeps the pods in the pending queue according to TTV values, while the latter implements the QoS-driven scheduler as described in the paper. Our QoS-diven scheduler implementation is available at repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes/tree/experiments-journal-paper)).

In order to support QoS-driven scheduler execution, we have used two applications: prometheus and kube-watch. The prometheus application is responsible for storing customized metrics in the system, while the kube-watch monitors the pod events (e.g. creation, updating and termination) in order to publish the QoS metrics (e.g. running and waiting times of a pod) on prometheus. These QoS metrics are required by QoS-driven scheduler while it is making allocation and preemption decisions. We evolve the kube-watch to compute the metrics of interest and our code is available in the repository ([link](https://github.com/cloudish-ufcg/cloudish-kube-watch/tree/experiments-journal-paper)).   

As mentioned before, the instructions about how to deploy a kubernetes cluster using the QoS-driven scheduler, how to submit a workload using the broker and how to understand the result files of a measurement experiment can be found in the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments-journal-paper)).
