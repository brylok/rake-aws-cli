# S3 PARENT COMMANDS
# wrapper create command for chaining subcommands
# example usage: `rake s3:create:website bucket=test123 profile=emptyset`
namespace :s3 do
  namespace :create do
    # example usage: `rake s3:create:website bucket=test123 profile=emptyset`
    desc 'Create an s3 bucket'
    task bucket: ["s3helper:createbucket"] do
      puts '## Bucket Created ##'
    end

    # example usage: `rake s3:create:website bucket=test123.com profile=emptyset`
    desc 'Create an s3 bucket and setup to host a website'
    task website: ["s3helper:createbucket", "s3helper:definewebsite"] do
      puts '## Website Created ##'
    end

    # example usage: `rake s3:create:forwarder bucket=www.test123.com forward=test123.com profile=emptyset`
    desc 'Create an s3 bucket and setup forwarding to another bucket'
    task forwarder: ["s3helper:createbucket", "s3helper:createforwarder"] do
      puts '## Website Forwarder Created ##'
    end
  end

  namespace :setup do
    # example usage: `rake s3:setup:fullwebsite bucket=test123abc.com profile=emptyset`
    desc 'Setup full website for hosting'
    task fullwebsite: [
      "s3helper:createbucket",
      "s3helper:definewebsite",
      "s3helper:createbucketwww",
      "s3helper:createforwarderwww"
    ] do
      puts 'Coming Soon'
    end
  end
end

# S3 HELPERS
namespace :s3helper do
  # CREATE
  # example usage: `rake s3createbucket bucket=test123`
  desc 'Creating an s3 bucket based on bucket name'
  task :createbucket do
    bucket_name = ENV['bucket']
    profile_name = ENV['profile'] || default_profile
    puts '## Creating S3 Bucket -- #{bucket_name}'
    sh "aws s3api create-bucket --bucket #{bucket_name} --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2 --profile #{profile_name}"
  end

  # example usage: `rake s3createbucket bucket=test123`
  desc 'Creating an s3 bucket based on bucket name'
  task :createbucketwww do
    bucket_name = "www." + ENV['bucket']
    profile_name = ENV['profile'] || default_profile
    puts '## Creating S3 Bucket -- #{bucket_name}'
    sh "aws s3api create-bucket --bucket #{bucket_name} --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2 --profile #{profile_name}"
  end

  # example usage: `rake s3definewebsite bucket=test123`
  desc 'Setup S3 bucket to host a website based on an example json file'
  task :definewebsite do
    bucket_name = ENV['bucket']
    profile_name = ENV['profile'] || default_profile
    puts '## Making Bucket an S3 Website -- #{bucket_name}'
    sh "aws s3api put-bucket-website --bucket #{bucket_name} --website-configuration file://example-configs/bucket-website-example.json --profile #{profile_name}"
  end

  # example usage: `rake s3createforwarder bucket=test123`
  desc 'Creating an s3 bucket for forwarding a bucket to a url'
  task :createforwarder do
    bucket_name = ENV['bucket']
    profile_name = ENV['profile'] || default_profile
    forward_target = ENV['forward'] || default_forward_address
    website_config = '{"RedirectAllRequestsTo": {"HostName": "' + "#{forward_target}" + '"}}'
    puts '## Making Bucket a Forwarder -- #{bucket_name}'
    sh "aws s3api put-bucket-website --bucket #{bucket_name} --website-configuration '#{website_config}' --profile #{profile_name}"
  end

  # example usage: `rake s3createforwarderwww bucket=test123.com`
  desc 'Creating an s3 bucket for forwarding a www domain -> non-www domain'
  task :createforwarderwww do
    bucket_name = "www." + ENV['bucket']
    profile_name = ENV['profile'] || default_profile
    forward_target = ENV['bucket'] || default_forward_address
    website_config = '{"RedirectAllRequestsTo": {"HostName": "' + "#{forward_target}" + '"}}'
    puts '## Making Bucket a Forwarder -- #{bucket_name}'
    sh "aws s3api put-bucket-website --bucket #{bucket_name} --website-configuration '#{website_config}' --profile #{profile_name}"
  end
end
