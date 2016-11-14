require 'test_helper'

class Granola::Rails::RenderingTest < ActionDispatch::IntegrationTest
  test "uses the granola serializer to render JSON" do
    get "/json"
    assert_response :success
    assert_equal '{"name":"Jane Doe","age":50}', response.body
  end

  test "can explicitly set which serializer to use" do
    get "/json/detailed_serializer"
    assert_response :success
    assert_equal \
      '{"first_name":"Jane","last_name":"Doe","age":50}', response.body
  end

  test "can serialize objects that don't have a serializer" do
    get "/json/plain"
    assert_response :success
    assert_equal '{"error":"Everything is not fine"}', response.body
  end

  test "can use Granola's mechanism to set status codes" do
    get "/json/status/granola"
    assert_response :bad_request
    assert_equal '{"error":"Everything is not fine"}', response.body
  end

  test "can use Rails' mechanism to set status codes" do
    get "/json/status/rails"
    assert_response :bad_request
    assert_equal '{"error":"Everything is not fine"}', response.body
  end

  test "works with Rails' respond_to and multiple registered formats" do
    get "/json/respond_to", env: { "HTTP_ACCEPT" => Mime[:yaml].to_s }
    assert_response :success
    assert_equal YAML.load(response.body), { name: "Jane Doe", age: 50 }

    get "/json/respond_to", env: { "HTTP_ACCEPT" => Mime[:json].to_s }
    assert_response :success
    assert_equal JSON.load(response.body), { "name" => "Jane Doe", "age" => 50 }
  end

  def get(path, env: {}, params: {})
    if Rails.version < "5"
      super(path, {}, env)
    else
      super
    end
  end
end
