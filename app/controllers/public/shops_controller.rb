class Public::ShopsController < ApplicationController
  # require 'httparty'
  require 'net/http'
  require 'base64'
  require 'json'

  def index
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
      # @favorite_shop=Shop.find_by(hotpepper_shop_id: @shops['id'])
      @favorite_shop=Shop.where(user_id: current_user.id)
      # @favorite_shop=Shop.exists?(hotpepper_shop_id: @shops['id'])
    end


  end


  def create
    shop = Shop.new(shop_params)
    shop.user_id=current_user.id
    # if Shop.exists?(hotpepper_shop_id: shop.hotpepper_shop_id)
    #   render :index
    # else
    shop.save
    redirect_to user_user_shops_path(current_user.id)
    # end
  end
  
  def destroy
    shop = Shop.find(params[:id])
    shop.destroy
    redirect_to user_user_shops_path(current_user.id)
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
  params.require(:shop).permit(:hotpepper_shop_id, :name, :address, :url, :catch, :open, :close, :genre, :budget_average, :access, :parking, :img)
end