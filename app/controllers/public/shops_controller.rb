class Public::ShopsController < ApplicationController
  # require 'httparty'
  require 'net/http'
  require 'base64'
  require 'json'

  def index
    # hotpepper_service = HotpepperService.new(ENV['SECRET_KEY'])
    # @hotpepper_shop = hotpepper_service.search_restaurants(params[:keyword])

    # api_key = ENV['SECRET_KEY']
    # keyword = params[:keyword]

    # response = HTTParty.get("https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{api_key}&keyword=#{keyword}&format=json")

    # if response.code == 200
    #   @shops = response['results']['shop']
    # else
    #   @shops = []
    #   flash[:alert] = 'Failed to fetch shop data from HotPepper API.'
    # end

    if params[:keyword]
      keyword = URI.encode_www_form_component(params[:keyword]) #文字列をURLとして認識できるようにする
      api_url = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{ENV['SECRET_KEY']}&keyword=#{keyword}&format=json"
      #25行目上記URLに対して、26~30行目でデータを渡す
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      
      response = https.request(request)
      response_body = JSON.parse(response.body) #JSON形式をparseでrails用の言語に変換する
      @shops = response_body['results']['shop'] #results>shop の階層までは記述している
    end


  end



  def search
    # require 'net/http'
    # require 'uri'
    # require 'json'

    # key = ENV['SECRET_KEY']
    # lat = '35.658'
    # lng = '139.7016'
    # range = 1
    # api = URI.parse("https://webservice.recruit.co.jp/hotpepper")
    # json = Net::HTTP.get(api)
    # @result = JSON.parse(json)
  end
end
