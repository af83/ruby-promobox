# encoding: UTF-8
require 'digest/md5'
require 'digest/sha1'
require 'base64'
require 'uri'
require 'open-uri'
require 'multi_json'

class Promobox

  API_VERSION = 'v3'
  API_URL = "http://api.promobox.fr/api/#{API_VERSION}"

  def initialize(api_key, login, password)
    @api_key = api_key
    @login = login
    @password = password
    @hash_password = Digest::MD5.digest("#{@password}{#{@api_key}}").unpack('H*').first
  end

  def coupons(params={})
    response = open(build_query(__method__, params)).read
    MultiJson.decode(response)
  end

  private

  def build_query(action, params)
    ts = Time.now.to_i
    token = Base64.encode64(Digest::SHA1.digest("#{@hash_password}#{ts}#{@api_key}")).chomp
    query = {
      ts: ts.to_s,
      login: @login,
      token: token
    }
    auth_params = URI.encode_www_form query
    encoded_params = URI.encode_www_form params
    "#{API_URL}/#{action}?#{auth_params}#{encoded_params}"
  end
end
