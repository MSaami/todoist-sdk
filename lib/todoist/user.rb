# frozen_string_literal: true

require 'todoist/config'

module Todoist
  # The User class is responsible for managing user information in Todoist.
  class User
    def initialize(client)
      @client = client
    end

    def info
      response = @client.get_request(Todoist::Config::URLS[:user].to_s)
      OpenStruct.new(response)
    end
  end
end
