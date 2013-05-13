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
```


Resources
---------

* http://promobox.fr/
* http://api.promobox.fr/doc/

Tests
-----

``` ruby
bundle exec ruby test/promobox_test.rb
```
