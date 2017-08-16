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

This will install the auth_provider initializer into `config/initializers/auth_provider.rb`, mount `AuthProvider::Engine` at `/oauth` in `config/routes.rb` and copy the database migration file.

At last, don't forget to run:

```bash
$ rake db:migrate
```


## Configuration

All the configurations of auth_provider can be found in `config/initializers/auth_provider.rb`, just check it out!


## License

[MIT License](http://opensource.org/licenses/MIT).
