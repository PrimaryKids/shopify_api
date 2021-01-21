# frozen_string_literal: true
require 'graphql/client'
require 'graphql/client/http'

module ShopifyAPI
  # GraphQL API.
  class GraphQL
    def initialize(path = '/admin/api/2020-10/graphql.json', schema = nil )
      uri = Base.site.dup
      uri.path = path
      @http = ::GraphQL::Client::HTTP.new(uri.to_s) do
        define_method(:headers) do |_context|
          Base.headers
        end
      end
      @schema = schema || ::GraphQL::Client.load_schema(@http)
      @client = ::GraphQL::Client.new(schema: @schema, execute: @http)
    end

    delegate :parse, :query, to: :@client
  end
end