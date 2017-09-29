# IAM
# example usage: `rake iamcreateuser username=Bob profile=emptyset`

namespace :iam do
  namespace :create do
    # example usage: `rake iam:create:user username=Bob profile=emptyset`
    desc 'Create an IAM user as well as their keys'
    task user: ["iamhelper:createuser", "iamhelper:createkeys"] do
      puts '## User Created ##'
      puts '## YOU MUST COPY THE KEYS ##'
    end
  end
end


namespace :iamhelper do

  # example usage: `rake iamhelper:createuser username=Bob profile=emptyset`
  desc 'Create an IAM User'
  task :createuser do
    profile_name = ENV['profile'] || default_profile
    user_name = ENV['username']
    puts 'Creating IAM User'
    sh "aws iam create-user --user-name #{user_name} --profile #{profile_name}"
  end

  # example usage: `rake iamhelper:createkeys username=Bob profile=emptyset`
  desc 'Create keys for the IAM User'
  task :createkeys do
    profile_name = ENV['profile'] || default_profile
    user_name = ENV['username']
    puts 'Creating Keys for IAM User'
    sh "aws iam create-access-key --user-name #{user_name} --profile #{profile_name}"
  end
end
