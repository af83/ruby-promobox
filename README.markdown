ruby-promobox
=============

Usage
-----


```ruby
@promobox = Promobox.new('apikey', 'demo@atipik.fr', 'password')
```

Implemented methods:

```ruby
@promobox.search(params)
@promobox.coupons(params)
@promobox.shops(params)
@promobox.coupon(id)
@promobox.shop(id)
```

Resources
---------

* http://promobox.fr/
* http://api.promobox.fr/doc/

Tests
-----

``` ruby
bundle exec rake
```
