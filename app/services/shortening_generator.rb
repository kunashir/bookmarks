class ShorteningGenerator < BaseService
  attr_reader :full_link
  API_KEY = ENV["SHORTENING_PROVIDER_API_KEY"]

  class ConnectionError < StandardError; end
  class InvalidJSON < StandardError; end

  def initialize(full_link)
    @full_link = full_link
  end

  def perform
    result = make_request(generate_path(full_link))
    parse_result(result)
  end

  private

  # Response example
  # {
  #     "url": {
  #         "status": 7,
  #         "fullLink": "https://corporatefinanceinstitute.com/resources/knowledge/finance/",
  #         "date": "2021-11-28",
  #         "shortLink": "https://cutt.ly/f1",
  #         "title": "Finance Articles - Self Study Guides to Learn Finance"
  #     }
  # }
  def parse_result(data)
    return unless data.is_a? Hash
    data = data["url"]
    return unless data["status"] == 7

    data["shortLink"]
  end

  def generate_path(full_link)
    "https://cutt.ly/api/api.php?key=#{API_KEY}&short=#{full_link}";
  end

  def make_request(path)
      headers = {"Content-Type" => "application/json"}

      begin
        response = HTTParty.get(path, headers: headers)
        response_message = response.message
        JSON.parse response.body
      rescue Net::OpenTimeout
        raise ConnectionError.new('Network error')
      rescue JSON::ParserError
        raise InvalidJSON.new('Error parsing response')
      end
    end
end
