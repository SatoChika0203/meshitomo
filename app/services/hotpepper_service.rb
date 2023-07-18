require 'httparty'

class HotpepperService
  include HTTParty
  base_uri 'https://webservice.recruit.co.jp/hotpepper'

  def initialize(api_key)
    @api_key = api_key
  end

  def search_restaurants(keyword)
    response = self.class.get('/gourmet/v1/', query: { key: @api_key, keyword: keyword })
    if response.success?
      return response.parsed_response['results']['shop']
    else
      return []
    end
  end
end
