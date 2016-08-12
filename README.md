# build-gamess
build the General Atomic and Molecular Electronic Structure System (GAMESS) on Ubuntu for simple, single-core runs

## What this does

The scripts will help you build GAMESS from source code on a virtual machine or container, relatively quickly and without need for specialized equipment or software. 
The default configuration is for a single-processor node and only 768 MB of shared memory. 
You can deply the resulting binary to other VMs/containers in a computational lab setting, with installation of the appropriate dependencies.

## What it doesn't do

As written, the scripts and instructions won't build you a parallel-ready, research-grade configuration for your cluster. 
The broad aim is to get students some basic, practical experience running computations with professional tools. 
This specific project helps instructors build and deploy those tools. 

## What is missing?

GAMESS is available to the public with an *academic* license, not an open-source one. 
*It cannot be distributed publicly.* 
For the scripts to work, you must first [request the source code](http://www.msg.ameslab.gov/gamess/License_Agreement.html) from [Mark Gordon's Quantum Theory Group](http://www.msg.chem.iastate.edu), and add it to your copy of this repository.

## Why use VMs?

Virtual machines and containers usually incur a performance hit; but they offer the benefit of portability and reproducibility. 
If you can get a particular computing environment working in their VM, then anyone else can replicate this environment with little effort. 
For an instructor trying to develop and troubleshoot tutorials for an entire class of students, the tradeoff between performance and reproducibility is worthwhile.

Combined with free software, VMs can enable a "distributed" computing lab model. 
Instead of you managing a fleet of computers or accounts on a cluster, students can install and run the software on their own. 
Most college students now own a powerful computer, or a thin client that can access a virtual one. 
This project will show two examples: Vagrant + Virtualbox for running a local VM, and the Cloud9 service for running a container on a remote server.
(Maybe someone can write one up for Digital Ocean.)

## The bigger picture

This project is part of a broader effort to put computational-chemistry tools into students hands. 
A future project will be devoted to the student's perspective, with installation not only of GAMESS but also Jmol, OpenBabel, Cloud9IDE, and others!

## Acknowledgments
