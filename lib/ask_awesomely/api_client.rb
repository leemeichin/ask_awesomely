module AskAwesomely
  class ApiClient

    USER_AGENT = "leemachin/ask_awesomely; (v#{AskAwesomely::VERSION})"
    BASE_URL = "https://api.typeform.io/v0.4"
    ENDPOINTS = {
      root: "/",
      create_typeform: "/forms",
      create_picture: "/images",
      create_design: "/designs"
    }

    def initialize
      Typhoeus::Config.user_agent = USER_AGENT
    end

    def get_info
      response = request.get(
        url_for(:root),
        headers: headers
      )

      JSON.parse(response.body)
    end

    def submit_typeform(typeform)
      response = request.post(
        url_for(:create_typeform),
        headers: headers,
        body: typeform.to_json
      )

      typeform.tap do |tf|
        body = JSON.parse(response.body)
        tf.update_with_api_response(body)
      end
    end

    def submit_picture(picture)
      response = request.post(
        url_for(:create_picture),
        headers: headers,
        body: picture.to_json
      )

      JSON.parse(response.body)
    end

    def submit_design(design)
      response = request.post(
        url_for(:create_design),
        headers: headers,
        body: design.to_json
      )

      JSON.parse(response.body)
    end

    private

    def request
      Typhoeus::Request
    end

    def url_for(endpoint)
      BASE_URL + ENDPOINTS[endpoint]
    end

    def headers(others = {})
      others.merge({
        "X-API-TOKEN" => AskAwesomely.configuration.typeform_api_key,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      })
    end

  end
end
