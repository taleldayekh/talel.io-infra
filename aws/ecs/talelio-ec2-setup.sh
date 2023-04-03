#!/bin/bash

# Append the talelio cluster name in the ECS config
# to launch the EC2 instance in the talelio cluster.
echo ECS_CLUSTER=talelio-cluster >> /etc/ecs/ecs.config
