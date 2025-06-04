# frozen_string_literal: true

module Todoist
  # This class provides methods to interact with the Task resource in the Todoist API.
  class TaskResource < BaseResource
    def add(content, **params)
      params = { content: content }.merge(params)
      Entities::Task.new @client.post_request(Todoist::Config::URLS[:task], params)
    end

    def list(**params)
      Collection.new @client.get_request(Todoist::Config::URLS[:task], params),
                     entity_class: Todoist::Entities::Task
    end

    def update(task_id, **params)
      Entities::Task.new @client.post_request(Todoist::Config::URLS[:update_task].gsub(':task_id', task_id), params)
    end

    def delete(task_id)
      @client.delete_request(Todoist::Config::URLS[:delete_task].gsub(':task_id', task_id))
      true
    end

    def retrieve(task_id)
      Entities::Task.new @client.get_request(Todoist::Config::URLS[:get_task].gsub(':task_id', task_id))
    end
  end
end
