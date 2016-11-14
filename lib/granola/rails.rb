# frozen_string_literal: true

require_relative "rails/version"

require "granola/rack"
require "rails/railtie"
require "active_support/concern"

module Granola
  # Helpers to integrate Granola into Rails' rendering flow.
  #
  # Example:
  #
  #   class API::UsersController < ApplicationController
  #     def show
  #       user = User.find(params[:id])
  #       render json: user, with: API::UserSerializer
  #     end
  #   end
  module Rails
    # Internal: Let ActionController know about any renderers you add to Granola
    # by defining an ActionController::Renderer based on Granola's.
    #
    # format - A Symbol with a rendering format (e.g. `:json`).
    #
    # Returns nothing.
    def self.install_renderer(format)
      ActionController::Renderers.remove(format)
      ActionController::Renderers.add(format) do |object, options|
        granola(object, **options.merge(as: format))
      end
    end

    include Granola::Rack

    # Public: Low-level API to respond with a serialized object. You should
    # prefer using ActionController's `render` with the serialization format
    # (e.g. `render json: object, with: SomeSerializer`).
    #
    # object    - An Object to be passed to a Granola::Serializer.
    # **options - Keywords to configure this response. See
    #             `Granola::Rack#granola` for a full list.
    #
    # Returns nothing.
    def granola(object, **options)
      options = { status: self.status, env: request.env }.update(options)
      status, headers, body = super(object, **options)

      response.status = status
      response.headers.update(headers)
      self.response_body = body
    end
  end

  module RendererRegistration # :nodoc:
    def self.render(format, *) # :nodoc:
      super.tap { Granola::Rails.install_renderer(format) }
    end
  end

  class << self
    # Defining a new rendering format should add it to Rails' rendering.
    prepend RendererRegistration
  end

  class Railtie < ::Rails::Railtie # :nodoc:
    initializer "granola.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        include Granola::Rails

        Granola.renderable_formats.each do |format|
          Granola::Rails.install_renderer(format)
        end
      end
    end
  end
end
