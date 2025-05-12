Gem::Specification.new do |spec|
  spec.name = 'todoist'
  spec.version = '0.1.0'
  spec.author = ['Mehrdad Sami']
  spec.email = ['mehrdadsaami@gmail.com']

  spec.summary = 'The SDK for todoist'

  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  spec.files = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '>= 13.0.0'
  spec.add_development_dependency 'webmock', '~> 3.20'
end
