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
      update_comment: "#{BASE_URL}/comments/:comment_id"
    }.freeze
  end
end
