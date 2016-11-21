# frozen_string_literal: true

require "rails/generators/named_base"

module Rails::Generators
  class SerializerGenerator < NamedBase
    source_root File.expand_path("../templates", __FILE__)
    check_class_collision suffix: "Serializer"

    class_option :parent, type: :string,
      desc: "The parent class for the generated serializer"

    def create_serializer_file
      template "serializer.rb.erb", File.join(
        "app/serializers", class_path, "#{file_name}_serializer.rb"
      )
    end

    hook_for :test_framework

    private

    def parent_class_name
      options.fetch("parent") do
        Object.const_defined?(:ApplicationSerializer) ?
          "ApplicationSerializer" : "Granola::Serializer"
      end
    end
  end
end
