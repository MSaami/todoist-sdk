# frozen_string_literal: true

require 'net/http'
require 'uri'

module Todoist
  class Client
    attr_reader :token

    def initialize
      @token = '1bed998575861864685f3a7571c9b338ec7f27c0'
    end

    def get_request(api_url)
      uri = URI(api_url)
      request = Net::HTTP::Get.new(uri)
      request['Authorization'] = "Bearer #{@token}"
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        response = http.request(request)
        response.body
      end
    end
  end
end
