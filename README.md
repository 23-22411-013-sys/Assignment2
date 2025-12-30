# Assignment2 – Terraform Infrastructure Deployment

## Project Overview
This project demonstrates the use of Terraform to deploy a modular cloud infrastructure on AWS. The infrastructure follows Infrastructure as Code (IaC) principles and is organized using reusable Terraform modules for networking, security, and web servers.

The deployment includes an Nginx reverse proxy and multiple Apache backend servers to achieve load balancing and high availability.

---

## Project Structure

Assignment2/
├── main.tf # Root Terraform configuration
├── variables.tf # Input variable definitions
├── outputs.tf # Output values
├── locals.tf # Local values and reusable expressions
├── terraform.tfvars # Variable values (excluded from Git)
├── .gitignore # Excludes sensitive and generated files
├── modules/
│ ├── networking/ # VPC, subnet, and routing resources
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ ├── security/ # Security groups and firewall rules
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ └── webserver/ # EC2 instance configuration
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── scripts/
│ ├── nginx-setup.sh # Nginx reverse proxy setup script
│ └── apache-setup.sh # Apache web server setup script
└── README.md

## Architecture Overview
┌─────────────────────────────────────────────────┐
│                  Internet                       │
└─────────────────┬───────────────────────────────┘
                  │
                  │ HTTPS (443)
                  │ HTTP (80)
                  ▼
         ┌────────────────────┐
         │   Nginx Server      │
         │  (Load Balancer)    │
         │   - SSL/TLS         │
         │   - Reverse Proxy   │
         │   - Load Balancing  │
         └────────┬───────────┘
                  │
      ┌───────────┼───────────┐
      │           │           │
      ▼           ▼           ▼
   ┌─────┐     ┌─────┐     ┌─────┐
   │Web-1│     │Web-2│     │Web-3│
   │     │     │     │     │(BKP)│
   └─────┘     └─────┘     └─────┘
   Primary     Primary     Backup

---

### Components Description

### Nginx Server
- Acts as reverse proxy and load balancer
- Handles HTTPS and SSL termination
- Forwards requests to backend servers

### Backend Web Servers
- Serve application content
- Multiple instances for high availability
- Backup server for fault tolerance

### Terraform
- Automates infrastructure deployment
- Manages EC2, security groups, and networking

## Prerequisites

### Required Tools
- Terraform
- AWS CLI
- SSH client
- Git

### AWS Credentials Setup
AWS credentials must be configured using:
aws configure

### SSH Key Setup
An SSH key pair is required to access EC2 instances.

## Deployment Instructions

1. Initialize Terraform
terraform init

2. Validate configuration
terraform validate

3. Deploy infrastructure
terraform apply
Type 'yes' when prompted.

## Configuration Guide

### Updating Backend IPs
Backend IPs can be updated in the Nginx upstream configuration file
located at /etc/nginx/conf.d/backend.conf.

After editing, reload Nginx:
sudo nginx -t
sudo systemctl reload nginx

### Nginx Configuration Explanation
- upstream defines backend servers
- proxy_pass forwards traffic
- SSL handles secure HTTPS access

## Testing Procedures

- Access the Nginx public IP in a browser
- Refresh page to verify load balancing
- Stop one backend server to test fault tolerance

## Architecture Details

### Network Topology
- Nginx in public subnet
- Backend servers in private subnet

### Security Groups
- Nginx allows ports 80 and 443 from internet
- Backend servers allow traffic only from Nginx

### Load Balancing Strategy
Nginx uses round-robin load balancing by default.

## Troubleshooting

### Common Issues
- 502 Bad Gateway: Backend server down
- Connection refused: Security group issue

### Log Locations
/var/log/nginx/access.log
/var/log/nginx/error.log

### Debug Commands
sudo systemctl status nginx
sudo nginx -t

Screenshots for each part are available in the screenshots/ directory.