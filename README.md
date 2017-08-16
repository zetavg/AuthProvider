# AuthProvider [![Build Status](https://travis-ci.org/zetavg/AuthProvider.svg?branch=master)](https://travis-ci.org/zetavg/AuthProvider) [![Coverage Status](https://coveralls.io/repos/github/zetavg/AuthProvider/badge.svg?branch=master)](https://coveralls.io/github/zetavg/AuthProvider?branch=master)

A simple authentication provider for Ruby/Rails app. Designed for mobile clients and is compatible with the OAuth 2.0 specification.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auth_provider'
```

And then execute:

```bash
$ bundle
```

Run the installation generator with:

```bash
$ rails generate auth_provider:install
```

And don't forget to run:

```bash
$ rake db:migrate
```


## License

[MIT License](http://opensource.org/licenses/MIT).
