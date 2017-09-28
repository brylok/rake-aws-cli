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
