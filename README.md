# Two-Tier AWS VPC Architecture for Secure Application Hosting

This project demonstrates the design, implementation, and validation of a robust two-tier AWS Virtual Private Cloud (VPC) architecture. The infrastructure was built from the ground up to create secure, isolated network segments for different application components, following AWS best practices for security and scalability.

---
##  Architectural Blueprint

The core of this project is a classic two-tier design, which separates the infrastructure into a public-facing subnet for web traffic and a completely isolated private subnet for backend services and databases. This segmentation is a fundamental security practice, as it prevents direct public access to critical application resources.

* **Public Subnet:** Hosts resources that need to be accessible from the internet, such as web servers. It has a route table entry that directs traffic through an Internet Gateway.
* **Private Subnet:** Hosts backend resources, such as application servers or databases, which should never be directly exposed to the internet. These resources can initiate outbound connections via a NAT Gateway (not pictured for simplicity) but cannot receive inbound connections from the internet.


*<p align="center">Figure 1: The target two-tier VPC architecture.</p>*
<img src="./assets/AWS Infrastructure Diagram.jpg" width="800" alt="AWS Infrastructure Diagram">

---
## Core Implementation & Configuration

The environment was built and configured manually to demonstrate a foundational understanding of each component.

* **VPC & Subnet Setup:** Established the core VPC with a custom IP address range. Within the VPC, I configured one public and one private subnet, each in a different availability zone for high availability.
* **Advanced Networking Controls:** Deployed an Internet Gateway to provide internet access to the public subnet. I configured custom public and private Route Tables to control the flow of traffic, ensuring the private subnet remained isolated.
* **Instance-Level Security:** Implemented granular security using both Network Access Control Lists (NACLs) for subnet-level traffic rules and Security Groups for instance-level control. This included configuring specific SSH and ICMP rules to enable secure access and communication between instances.
* **EC2 Deployment:** Launched Amazon Linux EC2 instances into both the public and private subnets to serve as web and application servers, respectively.

---
## Validation & Results

Rigorous testing was performed to validate that all networking and security configurations were working as intended.

### Deployed Infrastructure Resource Map
This resource map from the AWS console serves as proof of the deployed infrastructure, showing the relationship between the VPC, subnets, route tables, and Internet Gateway.

<img src="./assets/VPC Resource Map.jpg" width="800" alt="VPC Resource Map">
*<p align="center">Figure 2: The successfully deployed "homelab-vpc" infrastructure.</p>*

### Validation 1: Internal Connectivity (ping)
To confirm that the security groups and NACLs were correctly configured, a `ping` test was initiated from the public EC2 instance to the private EC2 instance. The successful response validated seamless and secure communication between the two tiers.

<img src="./assets/Ping validation.jpg" width="800" alt="Ping validation screenshot">
*<p align="center">Figure 3: A successful ping from the public server to the private server.</p>*

### Validation 2: External Connectivity (curl)
This test validates that the configured Internet Gateway and routing properly enable access to my application via the public internet. The image below shows proof of the public server successfully executing a `curl` command to access my own deployed web application, with HTML output confirming unrestricted outbound internet access.

<img src="./assets/Curl validation.jpg" width="800" alt="Curl validation screenshot">
*<p align="center">Figure 4: The public server fetching web content via curl, confirming internet access.</p>*

---
## 🚀 Skills Demonstrated

* **Amazon VPC:** VPC creation, subnetting, route tables, Internet Gateways, and network segmentation.
* **Network Security:** Configuration of Security Groups and Network ACLs (NACLs) for layered security.
* **Amazon EC2:** Launching, configuring, and managing instances in public and private subnets.
* **AWS Networking:** Deep understanding of core AWS networking concepts and traffic flow.
* **Systematic Troubleshooting:** Validating connectivity and security rules using standard tools like `ping` and `curl`.
