# encoding: UTF-8
require_relative 'test_helper'

describe Promobox do
  include RR::Adapters::TestUnit

  before do
    @promobox = Promobox.new('apikey', 'demo@atipik.fr', 'password')
  end

  def promobox_stub(action)
    fixture_file = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', "#{action}.json"))
    url = @promobox.send(:build_query, action, {})
    stub(OpenURI::OpenRead).read(url) { File.read fixture_file }
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
end
