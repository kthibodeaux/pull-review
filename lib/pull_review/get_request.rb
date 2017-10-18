module PullReview
  class GetRequest
    def result
      response.body
    end

    private

    def uri
      URI.parse(url)
    end

    def https
      Net::HTTP.new(uri.host, uri.port).tap do |config|
        config.use_ssl = true
      end
    end

    def request
      Net::HTTP::Get.new(uri.path).tap do |req|
        req['Authorization'] = "token #{ PullReview::TOKEN }"
        req['Content-Type'] = 'application/json'
        req.body = request_body
      end
    end

    def response
      https.request(request)
    end

    def request_body
      nil
    end
  end
end
