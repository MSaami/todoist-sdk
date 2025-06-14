# frozen_string_literal: true

module Todoist
  # The CommentResource class is responsible for managing comments in Todoist.
  class CommentResource < BaseResource
    def add(content:, **params)
      validate_task_id_or_project_id!(params)
      params = { content: content }.merge(params)

      Entities::Comment.new @client.post_request(url(:comment), params)
    end

    def all(**params)
      validate_task_id_or_project_id!(params)
      response = @client.get_request(url(:comment), params)

      Collection.new(response, entity_class: Entities::Comment)
    end

    def update(id:, **params)
      response = @client.post_request(
        url(:update_comment).gsub(':comment_id', id.to_s), params
      )
      Entities::Comment.new(response)
    end

    def delete(id:)
      @client.delete_request(
        url(:delete_comment).gsub(':comment_id', id.to_s)
      )
      true
    end

    def retrieve(id:)
      response = @client.get_request(
        url(:get_comment).gsub(':comment_id', id.to_s)
      )
      Entities::Comment.new(response)
    end

    private

    def validate_task_id_or_project_id!(params)
      return if params[:task_id] || params[:project_id]

      raise Error, 'Either task_id or project_id must be provided'
    end
  end
end
