# Terragrunt Learning

A demo repository with an opinionated structure to manage multi-env and multi-region
applications with Terragrunt.

The demo application is a simple Lambda that is triggered when an object iscreated
created in an S3 bucket and copies the object into another bucket.

Lambda code is heavily inspired by the one in [this](https://repost.aws/knowledge-center/lambda-copy-s3-files)
AWS repost.

Note: Most of the times you would want to use [S3 Replication](https://docs.aws.amazon.com/AmazonS3/latest/userguide/replication.html)
feature to perform what the lambda in this example does, it is just a demo! :)

### Additional tools
Along with Terraform, this repository assumes that you have all extra tools to ensure Terraforms workflow, these are:
* A Terminal emulator
* AWS CLI or a way to set up AWS credentials into your environment
  * If you are using Zsh and/or [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) we strongly recommend its [AWS plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws)
* Terraform and Terragrunt binaries
  * This repo includes [ASDF](https://asdf-vm.com/) Tool Versions files


## Official Links
List of official links:
* [Terraform download](https://developer.hashicorp.com/terraform/downloads)
* [Terragrunt download](https://terragrunt.gruntwork.io/docs/getting-started/install/)
* [Terragrunt docs](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/)
* [S3 Terraform module](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket)
* [Lambda Terraform module](https://github.com/terraform-aws-modules/terraform-aws-lambda)
