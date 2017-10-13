require 'json'
require 'yaml'
require 'pry'

module PullReview
  TOKEN = File.readlines("#{ ENV['HOME'] }/.pullreview").first
  REPO = `git remote -v | head -n 1 | cut -d':' -f2 | cut -d'.' -f1`.chomp
end

require 'pull_review/attributable'
require 'pull_review/bufferable'
require 'pull_review/get_index'
require 'pull_review/pull_request'
