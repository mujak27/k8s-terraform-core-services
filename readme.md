# Kubernetes Core Service Configuration Automation

## Overview

This script is designed to automate the configuration of Kubernetes CNI (cilium) and CSI (longhorn) using terraform

## Getting Started

Follow these steps to make use of this automation script for your Kubernetes Load Balancer configuration:

1. **Prepare Your Variables**
   - Create a `cluster.auto.tfvars` file based on the provided `cluster.auto.example.tfvars`. Customize this file with the values that match your specific use case.

2. **Execute the Script**
   - Run the script
     ```
     terraform apply
     ```
