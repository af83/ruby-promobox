# encoding: UTF-8
require_relative 'test_helper'

describe Promobox do

  it 'coupons' do
    p = Promobox.new('Votre Clé d\'api que nous vous avons communiqué', 'demo@atipik.fr', 'password')
    p.coupons.must_match /api.promobox.fr\/api\/v3\/coupons/
  end
end
