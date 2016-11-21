# frozen_string_literal: true

require "test_helper"
require "generators/rails/serializer_generator"

class SerializerGeneratorTest < Rails::Generators::TestCase
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  tests Rails::Generators::SerializerGenerator
  arguments %w(account)

  def test_generates_a_serializer
    run_generator
    assert_file \
      "app/serializers/account_serializer.rb",
      /class AccountSerializer < Granola::Serializer/
  end

  def test_generates_a_namespaced_serializer
    run_generator ["admin/account"]
    assert_file \
      "app/serializers/admin/account_serializer.rb",
      /class Admin::AccountSerializer < Granola::Serializer/
  end

  def test_uses_application_serializer_if_one_exists
    stub_constant :ApplicationSerializer do
      run_generator
      assert_file \
        "app/serializers/account_serializer.rb",
        /class AccountSerializer < ApplicationSerializer/
    end
  end

  def test_uses_given_parent
    stub_constant :ApplicationSerializer do
      run_generator ["Account", "--parent=MySerializer"]
      assert_file \
        "app/serializers/account_serializer.rb",
        /class AccountSerializer < MySerializer/
    end
  end

  def test_generates_test_unit_test
    run_generator ["Account", "-t=test_unit"]

    assert_file \
      "app/serializers/account_serializer.rb",
      /class AccountSerializer < Granola::Serializer/
    assert_file \
      "test/serializers/account_serializer_test.rb",
      /class AccountSerializerTest < ActiveSupport::TestCase/
  end

  def test_generates_rspec_test
    run_generator ["Account", "-t=rspec"]

    assert_file \
      "app/serializers/account_serializer.rb",
      /class AccountSerializer < Granola::Serializer/
    assert_file \
      "spec/serializers/account_serializer_spec.rb",
      /RSpec\.describe AccountSerializer do/
  end

  private

  def stub_constant(name)
    Object.const_set(name, Class.new)
    yield
  ensure
    Object.send(:remove_const, name)
  end
end
