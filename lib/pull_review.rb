require 'json'
require 'yaml'
require 'pry'

module PullReview
  TOKEN = File.readlines("#{ ENV['HOME'] }/.pullreview").first.chomp
  REPO = `git remote -v | head -n 1 | cut -d':' -f2 | cut -d'.' -f1`.chomp
end

require 'pull_review/bufferable'
require 'pull_review/comment_chain'
require 'pull_review/comment_positions'
require 'pull_review/diff'
require 'pull_review/diff_map'
require 'pull_review/get_index'
require 'pull_review/get_pull_request'
