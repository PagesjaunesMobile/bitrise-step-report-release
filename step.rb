require 'octokit'

def log_fail(message)
  puts
  puts "\e[31m#{message}\e[0m"
  exit(1)
end

def log_warn(message)
  puts "\e[33m#{message}\e[0m"
end

def log_info(message)
  puts
  puts "\e[34m#{message}\e[0m"
end

def log_details(message)
  puts "  #{message}"
end

def log_done(message)
  puts "  \e[32m#{message}\e[0m"
end

matches = /:([^\/]*)\//.match ENV["GIT_REPOSITORY_URL"]
sha = ENV["GIT_CLONE_COMMIT_HASH"]
repo_base = matches[1]
repo = repo_base +  "/" + ENV["BITRISE_APP_TITLE"]
pull_id = ENV["PULL_REQUEST_ID"]
authorization_token = ENV["auth_token"]

client = Octokit::Client.new access_token:authorization_token

new_branch = ENV["DEST_BRANCH"]
#client.create_ref repo, "heads/#{new_branch}", sha
report = client.create_pull_request repo, "develop", new_branch, "chore(changes): report changes", "code review OK"
