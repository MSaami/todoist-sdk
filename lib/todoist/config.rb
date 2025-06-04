# frozen_string_literal: true

module Todoist
  class Config
    BASE_URL = 'https://api.todoist.com/api/v1'

    URLS = {
      projects: "#{BASE_URL}/projects",
      user: "#{BASE_URL}/user",
      delete_project: "#{BASE_URL}/projects/:project_id",
      update_project: "#{BASE_URL}/projects/:project_id",
      get_project: "#{BASE_URL}/projects/:project_id",
      upload_file: "#{BASE_URL}/uploads",
      delete_file: "#{BASE_URL}/uploads?file_url=:file_url",
      comment: "#{BASE_URL}/comments",
      update_comment: "#{BASE_URL}/comments/:comment_id",
      delete_comment: "#{BASE_URL}/comments/:comment_id",
      get_comment: "#{BASE_URL}/comments/:comment_id",
      task: "#{BASE_URL}/tasks",
      update_task: "#{BASE_URL}/tasks/:task_id",
      delete_task: "#{BASE_URL}/tasks/:task_id",
      get_task: "#{BASE_URL}/tasks/:task_id",
      search_task: "#{BASE_URL}/tasks/filter",
      complete_task: "#{BASE_URL}/tasks/:task_id/close",
      uncomplete_task: "#{BASE_URL}/tasks/:task_id/reopen",
      move_task: "#{BASE_URL}/tasks/:task_id/move",
      completed_by_date: "#{BASE_URL}/tasks/completed/by_completion_date",
      completed_by_due_date: "#{BASE_URL}/tasks/completed/by_due_date"
    }.freeze
  end
end
