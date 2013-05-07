# encoding: UTF-8
require_relative 'test_helper'

describe Promobox do
  include RR::Adapters::TestUnit

  describe 'coupons' do
    before do
      @fixture_file = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'coupons.json'))
      @promobox = Promobox.new('apikey', 'demo@atipik.fr', 'password')
      url = @promobox.send(:build_query, 'coupons', {})
      stub(OpenURI::OpenRead).read(url) { File.read @fixture_file }
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
