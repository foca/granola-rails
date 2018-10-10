class TestsController < ApplicationController
  DEFAULTS = { first_name: "Jane", last_name: "Doe", age: 50 }

  before_action :load_resource

  def serialize_plain
    render json: @person
  end

  def serialize_detailed_serializer
    render json: @person, with: DetailedPersonSerializer
  end

  def serialize_plain_object
    render json: { error: "Everything is not fine" }
  end

  def serialize_status_code_granola
    render json: { error: "Everything is not fine" }, status: 400
  end

  def serialize_status_code_rails
    self.status = 400
    render json: { error: "Everything is not fine" }
  end

  def serialize_respond_to
    respond_to do |format|
      format.json { render json: @person }
      format.yaml { render yaml: @person }
    end
  end

  private

  def load_resource
    attrs = request.parameters.fetch(:person, {}).reverse_merge(DEFAULTS)
    @person = Person.new(attrs)
  end
end
