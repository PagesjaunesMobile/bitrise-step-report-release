require 'gitlab'

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


sha = ENV["GIT_CLONE_COMMIT_HASH"]
repo_base = ENV["GIT_REPOSITORY_URL"]
repo = repo_base[/:(.*).git/, 1]
authorization_token = ENV["auth_token"]

client = Gitlab.client(
  endpoint: 'https://gitlab.solocal.com/api/v4',
  private_token: authorization_token )

new_branch = ENV["DEST_BRANCH"]
#client.create_ref repo, "heads/#{new_branch}", sha
#report = client.create_merge_request repo, "chore(fix): report fixes", {target_branch: "develop", source_branch: new_branch}
new_branch = "feat/reportRelease"
client.create_merge_request repo, "chore(fix): report fixes", { source_branch: new_branch, target_branch: 'develop', description: "code review OK", approvals_before_merge: 0}

