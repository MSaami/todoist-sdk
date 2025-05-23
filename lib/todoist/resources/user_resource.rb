# frozen_string_literal: true

require 'todoist/config'

module Todoist
  # The User class is responsible for managing user information in Todoist.
  class UserResource < BaseResource
    def info
      Todoist::Entities::User.new @client.get_request(Todoist::Config::URLS[:user].to_s)
    end
  end
end
