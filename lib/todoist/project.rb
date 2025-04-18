# frozen_string_literal: true

require 'todoist/config'

module Todoist
  # The Project class is responsible for managing projects in Todoist.
  class Project
    def initialize(client)
      @client = client
    end

    def all
      @client.get_request(Todoist::Config::URLS[:projects])
    end
  end
end
