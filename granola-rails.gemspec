require "./lib/granola/rails/version"

Gem::Specification.new do |s|
  s.name        = "granola-rails"
  s.version     = Granola::Rails::VERSION
  s.summary     = "Rails interface to Granola serializers."
  s.description = <<-TEXT.gsub(/^\s+/, "")
    Granola provides a simple and fast API to serialize objects into multiple
    formats.

    Granola::Rails just simplifies using Granola from Rails apps.
  TEXT

  s.authors     = ["Nicolas Sanguinetti"]
  s.email       = ["contacto@nicolassanguinetti.info"]
  s.homepage    = "https://github.com/foca/granola-rails"
  s.license     = "MIT"

  s.files = Dir[
    "LICENSE",
    "README.md",
    "lib/granola/rails.rb",
    "lib/granola/rails/version.rb",
  ]

  s.add_dependency "rails", ">= 4.0", "< 6"

  # FIXME: Once Granola 1.0 launches, change this to depend on "~> 1.0"
  s.add_dependency "granola", ">= 0.13", "~> 0"
end
