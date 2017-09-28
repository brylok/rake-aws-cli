# BryLok AWS Toolkit

This is a set of Rake tasks designed to make workign with AWS easier.  To use this you will need to have the aws-cli installed and configured as well as Rake.


## S3 Buckets

Note: You must pass a bucket but passing a profile is optional.  The default profile is set at the top of the Rakefile.

#### Create a website and www-forwarder bucket

```sh
rake s3:setup:fullwebsite bucket=sometestwebsite.com profile=emptyset
```

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




## HOW-TO

#### Setup s3 for hosting
```sh
rake s3:create:website bucket=test123.com profile=emptyset | rake s3:create:forwarder bucket=www.test123.com forward=test123.com profile=emptyset
```



Reference:

[Route53 via CLI Reference](https://realguess.net/2013/12/06/amazon-route-53-via-command-line/)

[S3 via CLI Reference](https://snippets.aktagon.com/snippets/679-how-to-use-the-aws-command-line-interface)

[Hugo hosting on AWS, Detailed Guide](https://lustforge.com/2016/02/27/hosting-hugo-on-aws/)
