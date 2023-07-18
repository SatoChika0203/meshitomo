class Public::ShopsController < ApplicationController
  def index
    hotpepper_service = HotpepperService.new(ENV['SECRET_KEY'])
    @hotpepper_shop = hotpepper_service.search_restaurants(params[:keyword])
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
