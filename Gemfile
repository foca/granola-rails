source 'https://rubygems.org'
gemspec

rails_version = ENV.fetch("RAILS_VERSION", "default")
rails_version = case rails_version
                when "master"
                  [{ github: "rails/rails" }]
                when "default"
                  [">= 4.0", "< 6"]
                else
                  ["~> #{rails_version}"]
                end

gem "rails", *rails_version
