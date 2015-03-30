# Activeadmin::Logins

Logs login details after a user signs in, it stores IP address, user agent, country and city.
Uses [GeoIP](https://github.com/cjheath/geoip) gem for retrieving the location.

![](https://raw.githubusercontent.com/kollegorna/activeadmin-logins/master/screenshot.png)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activeadmin-logins'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeadmin-logins

## Usage

    rails generate active_admin:logins:install
    rake db:migrate

## Contributing

1. Fork it ( https://github.com/[my-github-username]/activeadmin-logins/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
