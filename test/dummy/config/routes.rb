Rails.application.routes.draw do
  get "/json", to: "tests#serialize_plain"
  get "/json/detailed_serializer", to: "tests#serialize_detailed_serializer"
  get "/json/plain", to: "tests#serialize_plain_object"
  get "/json/status/granola", to: "tests#serialize_status_code_granola"
  get "/json/status/rails", to: "tests#serialize_status_code_rails"
  get "/json/respond_to", to: "tests#serialize_respond_to"
end
