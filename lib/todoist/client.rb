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

    # Performs a GET request to the specified API URL with optional query parameters
    # @param api_url [String] The URL to send the GET request to
    # @param params [Hash] Optional query parameters to include in the request
    # @return [Hash, nil] Parsed JSON response or nil if no content returned
    def get_request(api_url, params = {})
      uri = URI(api_url)
      uri.query = URI.encode_www_form(params) unless params.empty?
      request = Net::HTTP::Get.new(uri)
      request['Authorization'] = "Bearer #{@token}"
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        response = http.request(request)
        handle_response(response)
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
        handle_response(response)
      end
    end

    def upload_request(api_url, file_path:)
      uri = URI(api_url)
      request = Net::HTTP::Post.new(uri)
      request['Authorization'] = "Bearer #{@token}"
      request.set_form([['file_name', File.open(file_path)]], 'multipart/form-data')
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        respone = http.request(request)

        handle_response(respone)
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
        handle_response(response)
      end
    end

    def projects
      @projects ||= ProjectResource.new(self)
      @projects
    end

    def user
      @user ||= UserResource.new(self)
      @user
    end

    def file
      @file ||= FileResource.new(self)
      @file
    end

    private

    def handle_response(response)
      raise Error.new(response.code.to_i, response.body) unless response.is_a?(Net::HTTPSuccess)

      return if response.body.nil?

      JSON.parse(response.body)
    end
  end
end
