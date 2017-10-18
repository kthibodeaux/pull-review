module PullReview
  class User
    def self.current
      @current ||= new(JSON.parse(PullReview::Request::GetAuthenticatedUser.new.result))
    end

    def initialize(json_data)
      @json_data = json_data
    end

    def name
      json_data.fetch('login')
    end

    private
    attr_reader :json_data
  end
end
