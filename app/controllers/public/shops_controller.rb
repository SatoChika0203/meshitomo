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

      @shop=Shop.new()
      # @user_shop=UserShop.new()
    end


  end

  def show

  end

  def create
  shop = Shop.new(shop_params)
  shop.user_id=current_user.id
  # user_shopを保存
  shop.save
  redirect_to recruitments_path


    # user_shop=current_user.user_shops.new(shop_id: shop_params[:id])
    # user_shop.id=shop_params[:id]
    # user_shop.name=shop_params[:name]
    # user_shop.catch=shop_params[:catch]
    # user_shop.address=shop_params[:address]
    # user_shop.open=shop_params[:open]
    # user_shop.close=shop_params[:close]
    # # user_shop.image=shop_params[:image]
    # user_shop.urls=shop_params[:urls]
    # user_shop.save


    # @id=shop_params[:id]
    # @name=shop_params[:name]
    # @catch=shop_params[:catch]
    # @address=shop_params[:address]
    # @open=shop_params[:open]
    # @close=shop_params[:close]
    # @image=shop_params[:image]
    # @urls=shop_params[:urls]

    # user_shops = current_user.user_shops.new(shop_id: @id)

    # user_shops.save

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

private

def shop_params
  params.require(:shop).permit(:shop_name, :shop_address, :shop_url)
end