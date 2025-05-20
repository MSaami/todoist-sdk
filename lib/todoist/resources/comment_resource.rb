# frozen_string_literal: true

module Todoist
  # The CommentResource class is responsible for managing comments in Todoist.
  class CommentResource
    def initialize(client)
      @client = client
    end

    def add(content:, **params)
      validate_task_id_or_project_id!(params)
      params = { content: content }.merge(params)

      Entities::Comment.new @client.post_request(Todoist::Config::URLS[:comment], params)
    end

    def all(**params)
      validate_task_id_or_project_id!(params)
      response = @client.get_request(Todoist::Config::URLS[:comment], params)

      Collection.new(response, entity_class: Entities::Comment)
    end

    def update(id:, **params)
      response = @client.post_request(
        Todoist::Config::URLS[:update_comment].gsub(':comment_id', id.to_s), params
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
