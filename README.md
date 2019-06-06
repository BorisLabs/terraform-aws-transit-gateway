# AWS Transit Gateway Terraform Module
Terraform module which creates [Transit Gateway resources](https://docs.aws.amazon.com/vpc/latest/tgw/what-is-transit-gateway.html) on AWS.

The following resources are supported:
- []()
- []()


This module aims to provide all connotations of setting up & sharing Transit Gateway resources for AWS.

## Usage
```HCL
module "tgw" {
  source  = "BorisLabs/transit-gateway/aws"
  version = "0.0.1"

}
```

# Examples
- Full Examples will be coming soon...
- [Complete Terragrunt for DX Conn, GW, VIF -- COMING SOON]()

## Terraform Versions
This module currently only supports Terraform v0.11.
Terraform 0.12 support is expected soon. Please follow [#3](https://github.com/BorisLabs/terraform-aws-transit-gateway/issues/1) for update

## Authors
Module managed by  
[Rob Houghton](https://github.com/ALLFIVE)  
[Josh Sinfield](https://github.com/JoshiiSinfield)  
[Ben Arundel](https://github.com/barundel)

## Notes
1. All Outputs are lists due to conditional creations of all resources.
   Only one of each resource is currently created therefore the following use of element should suffice.
   ```${element(module.tgw.transit_gateway_id, 0)}```  
   Please check code confirm this is still true.
   