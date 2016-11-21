# frozen_string_literal: true

require "rails/generators/named_base"

module TestUnit
  class SerializerGenerator < ::Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)

    def create_test_file
      template "serializer_test.rb.erb", File.join(
        "test/serializers", class_path, "#{file_name}_serializer_test.rb"
      )
    end
  end
end
