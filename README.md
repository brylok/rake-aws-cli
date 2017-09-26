# BryLok AWS Toolkit

This is a set of Rake tasks designed to make workign with AWS easier.  To use this you will need to have the aws-cli installed and configured as well as Rake.


## S3 Buckets

Note: You must pass a bucket but passing a profile is optional.  The default profile is set at the top of the Rakefile.

#### Create an s3 bucket

```sh
rake s3:create:bucket bucket=some-bucket-123
```

#### Create an S3 bucket and setup for hosting a website

```sh
rake s3:create:website bucket=test123.com profile=emptyset
```

#### List all buckets

```sh
rake listbuckets profile=emptyset
```

--------

## Route53 Commands

#### List all buckets

```sh
rake listhostedzones profile=emptyset
```

--------

## IAM Commands

#### Create an IAM user and create access keys

```sh
rake iam:create:user username=Bob profile=emptyset
```




Reference:

[Route53 Reference](https://realguess.net/2013/12/06/amazon-route-53-via-command-line/)
