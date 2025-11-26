# Terraform Research

## What is "Infrastructure as Code"?

Infrastructure as Code (IaC) is a practice that uses code to manage and provision IT infrastructure (severs, networks and databases), rather than through manual, physical setup (AWS Console for example)

## What is the difference between "Orchestration" and "Configuration Management"?

### Orchestration

Orchestration is the process of coordinating multiple automated tasks to manage the entire lifecycle of infrastructure (deployment, scaling and updates) across different environments.

Orchestration tools handle the execution of IaC code in the correct order, manage dependencies, enforce policies and react to changes to ensure the infrastructure operates as a unified system

Examples include Kubernetes and Docker Swarm

### Configuration Management

CM uses code to manage the software and setting on the infrastructure that was created and provisioned (by Orchestration)

TL:DR -> CM tools change the infrastructure from the current state, to the desired state

Examples inlcude Ansible, Puppet, Chef, SaltStack and CFEngine

## Which side does Terraform fall into?

Orchestration, although Terraform code tells us the state we want the resources in, pre-orchestration. Orchestration uses Terraform code to create, provision, and deploy resources.

## Why is Terraform so popular in the industry compared to other similar tools?

- Cloud agnostic
- Offers on-demand environments and templates
- Automates infrastructure deployment
- Modular, allows to group resources together
- Step-wise (terraform plan, terraform graph, execute)

## Examples of companies/industries that are using Terraform?

Capital One, JPMorgan Chase, Netflix, Oracle, and Amazon Web Services (AWS)

## How does Terraform connect/communicate with AWS?
