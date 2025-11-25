# VPCs

## VPC

VPC stands for Virtual Private Cloud. It is a private, logically isolated network within a public cloud.
An organisation can run its applications and manage its resources securely, without outsiders accessing information.

VPCs can be customised to allow access from specific IP address ranges, configure routing and security settings.
They can also manage cloud resources such as virtual servers, databases, and storage.

A default VPC has the following:

- Public subnet in each availability zone (AZ)
- An internet gateway
- Default route tables to allow internet access

Core components:

- Subnets
- Internet Gateway
- Route Tables
- Security Groups
- DNS Settings

## IP addresses

Public vs Private IP addresses:
Public IPs are accessible by the entire internet to connect external services and websites (Routers)

Private IPs cannot by accessed directly with the internet (but can using Network Address Translation) and only
needs to be unique within its local network (Laptop, Smart TV, Phone)

IPv4 vs IPv6:
IPv4 is typical IP address - 172.32.0.11 - each segment takes a range of 0-255 and there are 4.3 billion addresses
IPv6 consists of 32 hexadecimal values, which includes mandatory IP security, eliminates need for NAT, and allows devices to configure their own addresses, as opposed to IPv4's manual configuration, or use of a DHCP sever.

CIDR blocks:
CIDR - Classless Inter-Domain Routing
A collection of IP address that share the same network prefix
172.10.0.0/24 means that the first 24 bits (172.10.0) are the prefix, and the rest is "up for grabs".
Therefore the possible IP addresses in this CIDR block are 172.10.0.0 -> 172.10.0.255
192.32.0.0/16 gives us this range: 192.32.0.0 -> 192.32.255.255

Subnet masks:

A subnet mask is simply a 32-bit number in the style of an IP address. It will have the format of a number of 1s, followed by 0s. The 1s map to the network portion of the IP address, whereas the 0s map to the host portion. It can be used to improve efficiency by dividing networks into smaller, more managable subnets.

Reserved IP ranges:

Ranges that cannot be used on the internet:

- 10.0.0.0/8
- 172.16.0.0/12
- 192.168.0.0/16

There are other reserved ranges, such as:

- 127.0.0.0/8 (Loopback): Used for "localhost," which refers to the local machine
- 169.254.0.0/16 (Link-local): Automatically assigned when a device cannot obtain an IP address from a DHCP server
- 100.64.0.0/10 (Shared Address Space): Reserved for use by service providers when using Carrier-Grade NAT (CGNAT).
- 224.0.0.0/8 – 239.0.0.0/8 (Multicast): Reserved for multicast (formerly Class D) addresses.
- 240.0.0.0/8 – 255.0.0.0/8 (Future Use): Reserved for future use (formerly Class E). The address 255.255.255.255 is a limited broadcast address.

Network Address Translation (NAT):

A method used by routers to rewrite IP addresses on packets in transit, allowing multiple devices on a private network to share a single public IP address to connect to the internet. It conserves public IPv4 addresses and provides a layer of security by hiding the private IP addresses of internal devices from the public network.

## Subnets

Public and Private subnets:

Public subnets have direct route from the internet using an Internet Gateway.
Private subnets do not, instead they can access the internet by routing through a NAT, often located in the public subnet

Availability Zones and Subnets:

Availability zones (AZs) are physically isolated data centres within a region. A subnet exists within ONE AZ

## Gateways

NAT Gateways vs Internet Gateways:

NAT Gateways allow instances with no public IP addresses (or private IP addresses and private subnets) outbound access to the internet, whereas Internet Gateways allow bidirectional internet access for public subnets and public IP addresses.

Public subnets access the internet via the Internet Gateway

Private subnets need NAT to initiate connections to the internet, whilst preventing external systems from initiating connections to them. It uses its public IP address for the connection, but keeps the private IP hidden.

- Are there cost differences?
- Different architectures?

## Route Tables

- What does a "default" route table look like?
- Local routing
- 0.0.0.0/0 routing
- Routes to NAT gateway vs internet gateway
- How do RT association work?

## SGs and NACLs

- What are ports?
- Inbound vs Outbound rules
- Stateful vs stateless
- SG referencing
- Common SG architectures

Bonus:

- DNS
- Route53
- Different VPC designs

Reminders:

- Use images
- Make/link diagrams where possible
- Keep things fairly concise
- Guide should be usable by others
- Be ready to present your work tomorrow
