# frozen_string_literal: true

module Todoist
  # The LabelResource class is responsible for managing labels in Todoist.
  class LabelResource < BaseResource
    # Retrieves all labels.
    def all(**params)
      Collection.new @client.get_request(url(:labels), params),
                     entity_class: Todoist::Entities::Label
    end

    # Adds a new label to Todoist.
    # @param name [String] The name of the label. required.
    # @param params [Hash] Additional parameters for the label.
    def add(name:, **params)
      params = { name: name }.merge(params)
      Entities::Label.new @client.post_request(url(:labels), params)
    end

    # Deletes a label with the specified ID
    # @param id [String, Integer] The ID of the label to delete
    # @return [nil, Hash] nil if successful, error hash if failed
    def delete(id:)
      @client.delete_request(url(:delete_label).gsub(':label_id', id.to_s))
      true
    end

    def update(id:, **params)
      Entities::Label.new @client
        .post_request(url(:update_label).gsub(':label_id', id.to_s), params)
    end

    def retrieve(id:)
      Entities::Label.new @client
        .get_request(url(:get_label).gsub(':label_id', id.to_s))
    end
  end
end
