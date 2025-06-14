# frozen_string_literal: true

module Todoist
  # This class provides methods to interact with the Task resource in the Todoist API.
  class TaskResource < BaseResource
    def add(content, **params)
      params = { content: content }.merge(params)
      Entities::Task.new @client.post_request(url(:task), params)
    end

    def list(**params)
      Collection.new @client.get_request(url(:task), params),
                     entity_class: Todoist::Entities::Task
    end

    def update(task_id, **params)
      Entities::Task.new @client.post_request(
        url(:update_task).gsub(':task_id', task_id), params
      )
    end

    def delete(task_id)
      @client.delete_request(url(:delete_task).gsub(':task_id', task_id))
      true
    end

    def retrieve(task_id)
      Entities::Task.new @client.get_request(url(:get_task).gsub(':task_id', task_id))
    end

    def search(query)
      response = @client.get_request(url(:search_task), query: query)
      Collection.new(response, entity_class: Entities::Task)
    end

    def complete(task_id)
      @client.post_request(url(:complete_task).gsub(':task_id', task_id), {})
      true
    end

    def uncomplete(task_id)
      @client.post_request(url(:uncomplete_task).gsub(':task_id', task_id), {})
      true
    end

    def move(task_id:, project_id:)
      @client.post_request(url(:move_task).gsub(':task_id', task_id), { project_id: project_id })
      true
    end

    def completed_by_completion_date(from:, to:, **params)
      Collection.new @client.get_request(url(:completed_by_date), params.merge(since: from, until: to)),
                     entity_class: Entities::Task, main_key: 'items'
    end

    def completed_by_due_date(from:, to:, **params)
      Collection.new @client.get_request(url(:completed_by_due_date), params.merge(since: from, until: to)),
                     entity_class: Entities::Task, main_key: 'items'
    end
  end
end
