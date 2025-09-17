#This script automates the ping and curl tests you performed manually. 
#It uses the output from the CloudFormation stack to remotely connect to the public instance and run the validation commands. This demonstrates your ability to automate testing and verification.

#!/bin/bash

# A script to validate the connectivity of the two-tier VPC architecture.
# It assumes you have SSH access to the public instance.

# --- Configuration ---
# Replace with your EC2 Key Pair name (.pem file)
SSH_KEY="your-key-pair.pem"
# EC2 user for Amazon Linux
EC2_USER="ec2-user"

# --- Script Arguments ---
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <Public_Instance_IP> <Private_Instance_IP>"
    exit 1
fi

PUBLIC_IP=$1
PRIVATE_IP=$2

echo "--- Starting VPC Validation ---"
echo "Public Instance IP: $PUBLIC_IP"
echo "Private Instance IP: $PRIVATE_IP"
echo "Using SSH Key: $SSH_KEY"
echo "--------------------------------"

# --- Validation Step 1: Test Internal Connectivity (ping) ---
echo "✅ Step 1: Testing connectivity from Public to Private instance..."

# Use SSH to run the ping command on the public instance
# The -o StrictHostKeyChecking=no option avoids the key checking prompt
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$EC2_USER@$PUBLIC_IP" "ping -c 3 $PRIVATE_IP"

if [ $? -eq 0 ]; then
    echo "SUCCESS: Public instance can ping the Private instance."
else
    echo "FAILURE: Public instance CANNOT ping the Private instance. Check Security Groups and NACLs."
fi

echo "--------------------------------"

# --- Validation Step 2: Test External Connectivity (curl) ---
echo " Step 2: Testing outbound internet access from the Public instance..."

# Use SSH to run a curl command on the public instance to its own web server
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$EC2_USER@$PUBLIC_IP" "curl -s http://127.0.0.1"

if [ $? -eq 0 ]; then
    echo ""
    echo "SUCCESS: Public instance has outbound internet access and web server is running."
else
    echo "FAILURE: Public instance CANNOT access the internet or its web server is down. Check Route Table and IGW."
fi

echo "--------------------------------"
echo "Validation Complete."
