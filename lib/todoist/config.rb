# frozen_string_literal: true

module Todoist
  class Config
    BASE_URL = 'https://api.todoist.com/api/v1'

    URLS = {
      projects: "#{BASE_URL}/projects"
    }.freeze
  end
end
