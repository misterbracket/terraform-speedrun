# Terrafrom Speedrun Apollo

How to setup static web hosting using S3 and Cloudfront through Terraform.

## Prerequisites

* Install `oo` from here [here](https://sre.pleo.io/docs/getting-started/cheatsheets#oo-cli)
* Install the AWS CLI from [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* Install the Terrafrom Extension in your favorite editor [like this one](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
* Install Terrafrom from [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Scope
Deploy a minimal website with Terrafrom and AWS


Upload the website
```bash
 aws s3 sync ./website s3://apollo-goes-infra-lisbon-2023/
 aws s3 sync ./website s3://<bucket_name>/
```


### Credits

The code was inspired by this [article](https://awstip.com/how-to-setup-static-web-hosting-using-s3-and-cloudfront-through-terraform-392a6e1dd29d).
