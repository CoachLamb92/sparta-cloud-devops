# Two-tier VPC setup

## VPC Setup

### Navigate to VPC

#### <font color="orange">Create VPC</font>

- **Resource to create:** VPC only
- **Name tag:** se-morgan-2tier-vpc
- **IPv4 CIDR block:** IPv4 CIDR manual input
- **IPv4 CIDR:** 10.0.0.0/16
- **IPv6 CIDR block:** No IPv6 CIDR block
- **Tenancy:** Default
- **VPC encryption control:** None

#### <font color="orange">Create VPC</font>

## Subnet Setup

#### Click "Subnets"

#### <font color="orange">Create subnet</font>

- **VPC ID:** se-morgan-2tier-vpc
- **Subnet name:** se-morgan-public-subnet-1
- **Availability Zone:** eu-west-1a
- **IPv4 VPC CIDR block:** 10.0.0.0/16
- **IPv4 subnet CIDR block:** 10.0.2.0/24

#### <font color="blue">Add new subnet</font>

- **Subnet name:** se-morgan-private-subnet-1
- **Availability Zone:** eu-west-1b
- **IPv4 VPC CIDR block:** 10.0.0.0/16
- **IPv4 subnet CIDR block:** 10.0.3.0/24

#### <font color="orange">Create subnet</font>

## Route table Setup

#### Click "Route tables"

#### <font color="orange">Create route table</font>

- **Route table name:** se-morgan-2tier-vpc-public-rt
- **VPC:** se-morgan-2tier-vpc

#### <font color="orange">Create route table</font>

#### Subnet associations (TAB)

- Edit subnet associations
- Select "se-morgan-public-subnet-1"

#### <font color="orange">Save associations</font>

## Internet Gateway Setup

#### Click "Internet gateways"

#### <font color="orange">Create Internet gateway</font>

- **Internet gateway name:** se-morgan-2tier-vpc-ig

#### <font color="orange">Create Internet gateway</font>

#### <font color="green">Attach to a VPC</font>

- **Available VPCs:** se-morgan-2tier-vpc

#### <font color="orange">Attach Internet gateway</font>

### Route through Internet Gateway

#### Click "Route tables"

#### Select route table: se-morgan-2tier-vpc-public-rt

#### Routes (TAB)

#### <font color="blue">Edit routes</font>

#### <font color="blue">Add routes</font>

- **Destination:** 0.0.0.0/0
- **Target:** Internet Gateway
- Select: se-morgan-2tier-vpc-ig

#### <font color="orange">Save changes</font>

---

### **//Technically done, now time to check\\\\**

---

# Launch instance #1 (Private DB)

### Navigate to EC2

#### <font color="orange">Launch Instance</font>

- **Instance name:** se-morgan-db-private-sn
- **My AMIs:** se-morgan-mongodb-image-1
- **Key pair name:** se-morgan-cloud-networking
- **Network settings:** <font color="blue">Edit</font>
  - **VPC:** se-morgan-2tier-vpc
  - **Subnet:** se-morgan-private-subnet-1
  - **Auto-assign public IP:** Disable
  - **Create security group**
    - **Security group name:** se-morgan-mongodb-private-sg
    - **NB: Leave default ssh rule alone for testing**
    - <font color="blue">Add security group rule</font>
      - **Type:** Custon TCP
      - **Port range:** 27017
      - **Source:** 10.0.2.0/24 (Our public subnet can access)
      - **Description:** Public subnet instances

#### <font color="orange">Launch Instance</font>

---

# Launch instance #2 (Public App)

#### <font color="orange">Launch an instance</font>

- **Instance name:** se-morgan-app-public-sn
- **My AMIs:** se-morgan-node-app-image-1
- **Key pair name:** se-morgan-cloud-networking
- **Network settings:** <font color="blue">Edit</font>
  - **VPC:** se-morgan-2tier-vpc
  - **Subnet:** se-morgan-public-subnet-1
  - **Auto-assign public IP:** Enable
  - **Create security group**
    - **Security group name:** se-morgan-nodejs-public-sg
    - **NB: Leave default ssh rule alone for testing**
    - <font color="blue">Add security group rule</font>
      - **Type:** Custon TCP
      - **Port range:** 80
      - **Source:** 0.0.0.0/0 (The internet)
- **Advance details**
  - **User data:** user-data.sh

#### <font color="orange">Launch Instance</font>

---

Go to http://(ip-address)/posts where (ip-address) is replaced by the Public IPv4 address of your second instance (se-morgan-app-public-sn in this case).
