# SETTINGS
default_profile = 'emptyset'

# S3
# CREATE
# example usage: `rake s3createbucket bucket=test123`
desc 'Creating an s3 bucket based on bucket name'
task :s3createbucket do
  bucket_name = ENV['bucket']
  profile_name = ENV['profile'] || default_profile
  puts '## Creating S3 Bucket -- #{bucket_name}'
  sh "aws s3api create-bucket --bucket #{bucket_name} --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2 --profile #{profile_name}"
end

# example usage: `rake s3definewebsite bucket=test123`
desc 'Setup S3 bucket to host a website based on an example json file'
task :s3definewebsite do
  bucket_name = ENV['bucket']
  profile_name = ENV['profile'] || default_profile
  puts '## Making Bucket an S3 Website -- #{bucket_name}'
  sh "aws s3api put-bucket-website --bucket #{bucket_name} --website-configuration file://example-configs/bucket-website-example.json --profile #{profile_name}"
end

# wrapper create command for chaining subcommands
# example usage: `rake s3:create:website bucket=test123 profile=emptyset`
namespace :s3 do
  namespace :create do
    desc 'Create an s3 bucket'
    task bucket: :s3createbucket do
      puts '## Bucket Created ##'
    end

    desc 'Create an s3 bucket and setup to host a website'
    task website: [:s3createbucket, :s3definewebsite] do
      puts '## Website Created ##'
    end
  end
end


# ROUTE53
desc 'List all hosted zones owned by this profile'
task :route53listhostedzones do
  profile_name = ENV['profile'] || default_profile
  puts 'Retrieving list of all buckets'
  sh "aws route53 list-hosted-zones --profile #{profile_name}"
end


# wrapper create command for chaining subcommands
# example usage: `rake route53:listzones profile=emptyset`
namespace :route53 do
  task listzones: [:route53listhostedzones] do
    puts '## ZONE LIST COMPLETE ##'
  end
end



# IAM
# example usage: `rake iamcreateuser username=Bob profile=emptyset`
desc 'Create an IAM User'
task :iamcreateuser do
  profile_name = ENV['profile'] || default_profile
  user_name = ENV['username']
  puts 'Creating IAM User'
  sh "aws iam create-user --user-name #{user_name} --profile #{profile_name}"
end

# example usage: `rake iamcreatekeys username=Bob profile=emptyset`
desc 'Create keys for the IAM User'
task :iamcreatekeys do
  profile_name = ENV['profile'] || default_profile
  user_name = ENV['username']
  puts 'Creating Keys for IAM User'
  sh "aws iam create-access-key --user-name #{user_name} --profile #{profile_name}"
end


# wrapper create command for chaining subcommands
# example usage: `rake iam:create:user username=Bob profile=emptyset`
namespace :iam do
  namespace :create do
    task user: [:iamcreateuser, :iamcreatekeys] do
      puts '## USER & KEYS CREATED ##'
      puts 'MAKE SURE TO COPY DOWN THE KEYS!!'
    end
  end
end
