# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

require 'todoist/project'
require 'todoist/user'

module Todoist
  # The Client class is responsible for making API requests to Todoist.
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end

    # TODO: it should be extract to a dedicated class to work with network.
    def get_request(api_url)
      uri = URI(api_url)
      request = Net::HTTP::Get.new(uri)
      request['Authorization'] = "Bearer #{@token}"
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        response = http.request(request)
        JSON.parse(response.body)
      end
    end

    # TODO: it should be extract to a dedicated class to work with network.
    def post_request(api_url, params)
      uri = URI(api_url)
      request = Net::HTTP::Post.new(uri)
      request['Authorization'] = "Bearer #{@token}"
      request['content-type'] = 'application/json'
      request.body = params.to_json

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        response = http.request(request)
        JSON.parse(response.body)
      end
    end

    # Performs a DELETE request to the specified API URL
    # @param api_url [String] The URL to send the DELETE request to
    # @return [Hash, nil] Parsed JSON response or nil if no content returned
    def delete_request(api_url)
      uri = URI(api_url)
      request = Net::HTTP::Delete.new(uri)
      request['Authorization'] = "Bearer #{@token}"
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        response = http.request(request)
        response.body.empty? ? nil : JSON.parse(response.body)
      end
    end

    def projects
      @projects ||= Project.new(self)
      @projects
    end

    def user
      @user ||= User.new(self)
      @user
    end
  end
end
