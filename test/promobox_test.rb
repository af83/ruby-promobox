# encoding: UTF-8
require_relative 'test_helper'

describe Promobox do
  include RR::Adapters::TestUnit

  before do
    @promobox = Promobox.new('apikey', 'demo@atipik.fr', 'password')
  end

  def promobox_stub(action, params={})
    file = "#{action}.json"
    file = "#{action}_#{URI.encode_www_form params}.json" unless params.empty?
    fixture_file = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', file))
    url = @promobox.send(:build_query, action, params)
    stub(Kernel).open(url) { File.read fixture_file }
  end

  describe 'Net error' do
    it 'should be nil' do
      @promobox.send(:decode_url, 'af83').must_equal nil
    end
  end

  describe 'search' do
    before do
      promobox_stub('search')
    end

    it 'should respond' do
      search = @promobox.search
      search.must_be_instance_of Hash
      search['data'].wont_be_empty
      search['total_page'].must_equal 22
      search['total_item'].must_equal 430
    end
  end

  describe 'coupons' do
    before do
      promobox_stub('coupons')
    end

    it 'should respond' do
      coupons = @promobox.coupons
      coupons.must_be_instance_of Hash
      coupons['data'].wont_be_empty
      coupons['current_page'].must_equal 1
      coupons['total_page'].must_equal 28
      coupons['total_item'].must_equal 544
    end
  end

  describe 'shops' do
    describe 'without params' do
      before do
        promobox_stub('shops')
      end

      it 'should respond empty data' do
        shops = @promobox.shops
        shops.must_be_instance_of Hash
        shops['data'].must_be_empty
        shops['current_page'].must_equal 1
        shops['total_page'].must_equal 0
        shops['total_item'].must_equal 0
      end
    end

    describe 'with params' do
      before do
        @params = {lat: '49.824837', lon: '3.280160'}
        promobox_stub('shops', @params)
      end

      it 'should respond' do
        shops = @promobox.shops(@params)
        shops.must_be_instance_of Hash
        shops['data'].wont_be_empty
        shops['current_page'].must_equal 1
        shops['total_page'].must_equal 260
        shops['total_item'].must_equal 5187
      end
    end
  end

  describe 'coupon' do
    it 'must have an id' do
      proc { @promobox.coupon }.must_raise ArgumentError
    end

    describe 'invalid id' do
      before do
        promobox_stub('coupon/af83')
      end

      it 'should respond' do
        coupon = @promobox.coupon 'af83'
        coupon['status'].must_equal 'error'
        coupon['status_code'].must_equal 404
      end
    end

    describe 'valid id' do
      before do
        promobox_stub('coupon/7465')
      end

      it 'should respond' do
        coupon = @promobox.coupon '7465'
        coupon['status'].must_equal nil
        coupon['id'].must_equal 7465
      end
    end
  end

  describe 'shop' do
    it 'must have an id' do
      proc { @promobox.shop }.must_raise ArgumentError
    end

    describe 'invalid id' do
      before do
        promobox_stub('shop/af83')
      end

      it 'should respond' do
        shop = @promobox.shop 'af83'
        shop['status'].must_equal 'error'
        shop['status_code'].must_equal 404
      end
    end

    describe 'valid id' do
      before do
        promobox_stub('shop/2004')
      end

      it 'should respond' do
        shop = @promobox.shop '2004'
        shop['status'].must_equal nil
        shop['id'].must_equal 2004
      end
    end
  end
end
