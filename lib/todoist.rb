# frozen_string_literal: true

require 'todoist/resources/base_resource'
require 'todoist/resources/user_resource'
require 'todoist/resources/project_resource'
require 'todoist/resources/file_resource'
require 'todoist/resources/comment_resource'
require 'todoist/resources/task_resource'
require 'todoist/resources/section_resource'

require 'todoist/config'
require 'todoist/client'

require 'todoist/entities/entity'
require 'todoist/entities/user'
require 'todoist/entities/project'
require 'todoist/entities/file'
require 'todoist/entities/comment'
require 'todoist/entities/task'
require 'todoist/entities/section'

require 'todoist/version'
require 'todoist/error'
require 'todoist/collection'

# Todoist API wrapper
module Todoist
end
