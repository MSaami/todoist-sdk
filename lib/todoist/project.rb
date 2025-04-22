# frozen_string_literal: true

require 'todoist/config'

module Todoist
  # The Project class is responsible for managing projects in Todoist.
  class Project
    def initialize(client)
      @client = client
    end

    def all
      response = @client.get_request(Todoist::Config::URLS[:projects])
      OpenStruct.new(response)
    end

    # Add a new project to Todoist.
    # @name [String] The name of the project. required.
    # @params [Hash] Additional parameters for the project.
    def add(name, params = {})
      params = { name: name }.merge(params)
      @client.post_request(Todoist::Config::URLS[:projects], params)
    end

    # Deletes a project with the specified ID
    # @param id [String, Integer] The ID of the project to delete
    # @return [nil, Hash] nil if successful, error hash if failed
    def delete(id)
      @client
        .delete_request(Todoist::Config::URLS[:delete_project]
          .gsub(':project_id', id.to_s))
    end

    def update(id, params = {})
      @client
        .post_request(Todoist::Config::URLS[:update_project]
          .gsub(':project_id', id.to_s), params)
    end
  end
end
