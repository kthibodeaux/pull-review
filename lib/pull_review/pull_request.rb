module PullReview
  class PullRequest
    include Attributable

    def self.all
      @all ||= JSON.parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "https://api.github.com/repos/#{ PullReview::REPO }/issues"`)
        .select { |e| e.has_key?('pull_request') }
        .map { |e| PullRequest.new(e) }
    end

    attribute :pull_request, :url
    attribute :number
    attribute :title
    attribute :created_at
    attribute :user, :login

    def initialize(json_data)
      @json_data = json_data
    end

    def labels
      @labels ||= json_data
        .fetch('labels')
        .map { |e| "[ #{ e.fetch('name') } ]" }
        .join(' ')
    end

    private
    attr_reader :json_data
  end
end
