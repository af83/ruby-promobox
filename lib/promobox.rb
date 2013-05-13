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

  %w{coupons search shops}.each do |m|
    define_method m do |*params|
      url = build_query(m, params.first || {})
      decode_url(url)
    end
  end

  def coupon(id)
    url = build_query("#{__method__}/#{id}")
    decode_url(url)
  end

  def shop(id)
    url = build_query("#{__method__}/#{id}")
    decode_url(url)
  end

  private

  def decode_url(url)
    response = Kernel.open(url)
    MultiJson.decode(response)
  end

  def build_query(action, params = {})
    ts = Time.now.to_i
    token = Base64.encode64(Digest::SHA1.digest("#{@hash_password}#{ts}#{@api_key}")).chomp
    query = {
      ts: ts.to_s,
      login: @login,
      token: token
    }
    auth_params = URI.encode_www_form query
    encoded_params = URI.encode_www_form params
    url = "#{API_URL}/#{action}?#{auth_params}"
    url += "&#{encoded_params}" unless params.nil? || params.empty?
    url
  end
end
