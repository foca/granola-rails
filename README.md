# Granola::Rails [![Build Status](https://img.shields.io/travis/foca/granola-rails.svg)](https://travis-ci.org/foca/granola-rails) [![RubyGem](https://img.shields.io/gem/v/granola-rails.svg)](https://rubygems.org/gems/granola-rails)

Integrate [Granola](https://github.com/foca/granola) into Rails' rendering.

## Usage

Once you install it, you can just use `render` to use Granola serializers:

``` ruby
class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user
  end
end
```

This would infer a `UserSerializer` (in `app/serializers/user_serializer.rb`).
You can pass any options to this method that you could pass to
[`Granola::Rack#granola`][granola-rack]. For example, to use a different
serializer:

``` ruby
class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user, with: DetailedUserSerializer
  end
end
```

[granola-rack]: https://github.com/foca/granola/blob/master/lib/granola/rack.rb

### Serialization formats

Any serialization format you add to Granola via `Granola.render` will be
available to render through rails. For example:

``` ruby
# config/initializers/granola.rb
Granola.render :yaml, via: YAML.method(:dump), content_type: Mime[:yaml].to_s

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def show
    user = User.find(params[:id])

    respond_to do |format|
      format.json { render json: user }
      format.yaml { render yaml: user }
    end
  end
end
```

## Rails Generators

This library provides a `serializer` generator:

``` bash
$ rails generate serializer user
      create  app/serializers/user_serializer.rb
      invoke  test_unit
      create    test/serializers/user_serializer_test.rb
```

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'granola-rails'
```

And then execute:

``` sh
$ bundle
```

Or install it yourself as:

``` sh
$ gem install granola-rails
```

## License

The gem is available as open source under the terms of the MIT License. See the
[LICENSE](./LICENSE) for detjsonails.
