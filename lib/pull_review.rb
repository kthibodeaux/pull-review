require 'net/http'
require 'json'
require 'yaml'
require 'pry'

module PullReview
  module View; end
  module Request; end

  TOKEN = File.readlines("#{ ENV['HOME'] }/.pullreview").first.chomp
  REPO = `git remote -v | head -n 1 | cut -d':' -f2 | cut -d'.' -f1`.chomp
end

require 'pull_review/bufferable'
require 'pull_review/comment_chain'
require 'pull_review/comment_positions'
require 'pull_review/comment_presenter'
require 'pull_review/diff'
require 'pull_review/diff_map'
require 'pull_review/pull_request'
require 'pull_review/save_comment'
require 'pull_review/requests/post_comment'
require 'pull_review/views/comment_chain'
require 'pull_review/views/new_comment'
require 'pull_review/views/pull_request'
require 'pull_review/views/pull_request_list'
