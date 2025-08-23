require_relative 'lib/todoist/version'

Gem::Specification.new do |spec|
  spec.name = 'todoist-sdk'
  spec.version = Todoist::VERSION
  spec.authors = ['Mehrdad Sami']
  spec.email = ['mehrdadsaami@gmail.com']

  spec.summary = 'A comprehensive Ruby SDK for the Todoist API'
  spec.description = 'A Ruby SDK providing an intuitive interface to interact with Todoist\'s task management API, including support for tasks, projects, labels, comments, sections, and file uploads.'
  spec.homepage = 'https://github.com/msaami/todoist-sdk'
  
  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/msaami/todoist-sdk/issues',
    'changelog_uri' => 'https://github.com/msaami/todoist-sdk/blob/main/CHANGELOG.md',
    'documentation_uri' => 'https://github.com/msaami/todoist-sdk',
    'source_code_uri' => 'https://github.com/msaami/todoist-sdk'
  }

  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  spec.files = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '>= 13.0.0'
  spec.add_development_dependency 'webmock', '~> 3.20'
end
