# AuthProvider

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

And install the migrations:

```bash
$ rails generate auth_provider:migration
```

Last, don't forget to run:

```bash
$ rake db:migrate
```


## License

[MIT License](http://opensource.org/licenses/MIT).
