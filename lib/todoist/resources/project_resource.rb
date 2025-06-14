# frozen_string_literal: true

require 'todoist/config'

module Todoist
  # The Project class is responsible for managing projects in Todoist.
  class ProjectResource < BaseResource
    def all(**params)
      Collection.new @client.get_request(url(:projects), params),
                     entity_class: Todoist::Entities::Project
    end

    # Add a new project to Todoist.
    # @name [String] The name of the project. required.
    # @params [Hash] Additional parameters for the project.
    def add(name, params = {})
      params = { name: name }.merge(params)
      Entities::Project.new @client.post_request(url(:projects), params)
    end

    # Deletes a project with the specified ID
    # @param id [String, Integer] The ID of the project to delete
    # @return [nil, Hash] nil if successful, error hash if failed
    def delete(id)
      @client
        .delete_request(url(:delete_project)
          .gsub(':project_id', id.to_s))
      true
    end

    def update(id, params = {})
      Entities::Project.new @client
        .post_request(url(:update_project)
          .gsub(':project_id', id.to_s), params)
    end

    def retrieve(id)
      Entities::Project.new @client
        .get_request(url(:get_project).gsub(':project_id', id.to_s))
    end
  end
end
