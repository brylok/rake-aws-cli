# ROUTE53
# example usage: `rake route53listzones profile=emptyset`
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
