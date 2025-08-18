# frozen_string_literal: true

module Todoist
  class SectionResource < BaseResource
    def add(name:, project_id:, **params)
      params = { name: name, project_id: project_id }.merge(params)
      Entities::Section.new @client.post_request(url(:section), params)
    end

    def all(**params)
      Collection.new @client.get_request(url(:section), params),
                     entity_class: Todoist::Entities::Section
    end

    def retrieve(id:)
      Entities::Section.new @client.get_request(url(:get_section).gsub(':section_id', id))
    end

    def update(id:, **params)
      Entities::Section.new @client.post_request(url(:update_section).gsub(':section_id', id), params)
    end

    def delete(id:)
      @client.delete_request(url(:delete_section).gsub(':section_id', id))
      true
    end
  end
end