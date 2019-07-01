# QoS-driven scheduling experiments

This repository contains the input data used in the experiments described in the paper entitled "QoS-driven scheduling in the cloud", submitted to ACM Transactions on Computer Systems. It also contains instructions on how to run simulation and measurement experiments, using the artifacts that generated the paper results.

# Input data

## workload

This repository contains all workloads used in the experiments described in the paper: google samples and synthetic workloads for validation. The google samples were submitted only to the simulator. A workload file submitted to the simulator contains the following fields: 
1. *timestamp* (admission time of the task)
2. *task id*
3. *job id*
4. *task duration*
5. *cpu requested*
6. *ram requested*
7. *task priority*
8. *anti-affinity constraint* (the value 1 indicates that the specific job is anti-affinity constrained, which means that no more than one task of this job can be allocated in the same host)
9. *a list of placement constraints*

In the case of synthetic workloads, they were submitted to the simulator and to the Kubernetes system. In order to automate the execution of measurement experiments on Kubernetes, we have developed an application (called broker) that submits requests to Kubernetes based on a workload description file. Although the content of the files used is essentially the same for both simulation and measurement experiments, there are some differences in the format of the files. A workload file submitted to the broker contains the following fields:
1. *time passed since the begin of the experiment* (admission time of the task)
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

The broker, as well as the instructions on how to use it, are available at the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments-journal-paper)). Besides, the same repository has instructions on how to deploy a Kubernetes cluster using the QoS-driven scheduler, how to submit a workload using the broker, and a description of the format of the result files of a measurement experiment. 

## infrastructure

This repository also contains all infrastructure definitions used in the experiments described in the paper. An infrastructure description file used as input to the simulator contains the following fields: 
1. *host id*
2. *host name*
3. *cpu capacity*
4. *ram capacity*
5. *a list of attributes* (key=value format)

In the case of the measurement experiments, the infrastructure is formed by adding nodes into the kubernetes cluster. In the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments-journal-paper)) it is possible to find instructions on how to deploy a Kubernetes cluster using the QoS-driven scheduler, how to submit a workload using the broker, and a description of the format of the result files of a measurement experiment.

# Experiments results

This repository also contains the results of the experiments described in the paper. The result files have different formats for simulation and measurement experiments. Both formats are described below. 

## Simulation

In the case of simulation experiments, the results were divided into two parts for each capacity level. One compacted file for each part is available in this repository. Each part contains the results for both scheduling policies (priority-based and QoS-driven) of five workload samples. The part01 contains the results for samples 1 to 5, and part02 contains the results for samples 6 to 10. Once the file is uncompressed, each simulation result file has the following fields:

1. *task id*
2. *runtime* (the duration of the task, i.e. the amount of time that the task needs to be running to be completed)  
3. *slo str* (the service class of the task)
4. *availability* (the final availability of the task)
5. *submittime* (admission time of the task)
6. *scheduling* (the scheduling policy simualted)
7. *cpu req* (the amount of cpu requested by the task)
8. *workload* (the workload sample of the task)

## Measurement


# Simulator 

We have implemented the simulator that is able to emulate both scheduling policies: priority-based and QoS-driven. Our simulator was developed in Erlang on top of the [Sim-diasca simulation framework](http://sim-diasca.com) and it is available at the repository ([link](https://forge.ericsson.net/plugins/git/ufcg-er/cloudish?a=tree&hb=experiments-journal-paper)). In order to run a simulation test, you need to go into the cloudish directory and run the following command:

`bash run_simulation.sh $SIM_DURATION $SCHEDULING_POLICY $WORKLOAD_FILE $INFRASTRUCTURE_FILE 3 $SAFTEY_MARGIN $PERIODICITY false $PREEMPTION_OVERHEAD_FILE $MIGRATION_OVERHEAD_FILE 1 $LIMITING_PREEMPTION $EXTRA_OVERHEAD`

where,
- *SIM_DURATION* is the duration of the simulation test in seconds;
- *SCHEDULING_POLICY* is the scheduling policy to be simulated {ttv | priority};
- *WORKLOAD_FILE* is the name of the workload file description that should be located in the data directory;
- *INFRASTRUCTURE_FILE* is the name of the infrastructure file description that should be located in the data directory;
- *SAFTEY_MARGIN* is the safety margin in seconds to be considered while the the QoS-driven scheduler is making decisions; 
- *PERIODICITY* is the maximum time between two sequential processing of the pending queue;
- *PREEMPTION_OVERHEAD_FILE* is the name of the file with a set of preemption overhead values to be considered when an instance is allocated in the same host that it was previously allocated. This file should be located in the data directory;
- *MIGRATION_OVERHEAD_FILE* is the name of the file with a set of migration overhead values to be considered when an instance is allocated in a host different to the one it was previously allocated. This file should be located in the data directory;
- *LIMITING_PREEMPTION* is the flag that indicates if the mechanism to limit the number of preemption should be used {true | false};
- *EXTRA_OVERHEAD* indicates the extra value to be incremented to the default value of 1-SLO, to be considered as the maximum overhead of preemption. For instance, 0 indicates that the limit of overhead is set to 1-SLO.

# QoS-driven scheduler (prototype implementation for kubernetes)

We have implemented a proof-of-concept of the QoS-driven scheduler for the Kubernetes system. In the kubernetes ecosystem, instances are represented by pods that are associated with a deployment controller. In this study, we have considered the relation 1-to-1 between a deployment and a pod. In other words, all deployments must keep one pod running. Basically, two components were modified from the original Kubernetes code: Cloudish queue and Cloudish scheduler. The former keeps the pods in the pending queue sorted by their TTV values, while the latter implements the QoS-driven scheduler, as described in the paper. Our QoS-driven scheduler implementation is available at the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes/tree/experiments-journal-paper)).

In order to support the QoS-driven scheduler execution, we have used two Kubernetes applications: prometheus and kube-watch. Prometheus is responsible for storing customized metrics in the system, while kube-watch monitors pod events (e.g. creation, updating and termination) in order to publish the QoS metrics (e.g. running and waiting times of a pod) on prometheus. These QoS metrics are required by the QoS-driven scheduler to make allocation and preemption decisions. We evolve the kube-watch application to compute the metrics of interest, and our code is available in the repository ([link](https://github.com/cloudish-ufcg/cloudish-kube-watch/tree/experiments-journal-paper)).   

As mentioned before, the instructions about how to deploy a Kubernetes cluster using the QoS-driven scheduler, how to submit a workload using the broker, and a description of the format of the result files of a measurement experiment can be found in the repository ([link](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/tree/experiments-journal-paper)).
