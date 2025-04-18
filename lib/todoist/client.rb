# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

module Todoist
  # The Client class is responsible for making API requests to Todoist.
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def get_request(api_url)
      uri = URI(api_url)
      request = Net::HTTP::Get.new(uri)
      request['Authorization'] = "Bearer #{@token}"
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        response = http.request(request)
        JSON.parse(response.body)
      end
    end

    def projects
      @projects ||= Project.new(self)
      @projects
    end
  end
end
