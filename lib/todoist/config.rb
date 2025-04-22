# frozen_string_literal: true

module Todoist
  class Config
    BASE_URL = 'https://api.todoist.com/api/v1'

    URLS = {
      projects: "#{BASE_URL}/projects",
      user: "#{BASE_URL}/user",
      delete_project: "#{BASE_URL}/projects/:project_id",
      update_project: "#{BASE_URL}/projects/:project_id"
    }.freeze
  end
end
