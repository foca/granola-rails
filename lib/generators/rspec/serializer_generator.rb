# frozen_string_literal: true

require "rails/generators/named_base"

module Rspec
  class SerializerGenerator < ::Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)

    def create_test_file
      template "serializer_spec.rb.erb", File.join(
        "spec/serializers", class_path, "#{file_name}_serializer_spec.rb"
      )
    end
  end
end
