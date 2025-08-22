# Todoist SDK for Ruby

[![Gem Version](https://badge.fury.io/rb/todoist.svg)](https://badge.fury.io/rb/todoist)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ruby](https://img.shields.io/badge/Ruby-3.0%2B-red.svg)](https://www.ruby-lang.org/)

A comprehensive Ruby SDK for the [Todoist API](https://developer.todoist.com/rest/v1/), providing an intuitive and elegant interface to interact with Todoist's powerful task management platform.

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Authentication](#authentication)
- [Features](#features)
- [Usage](#usage)
  - [Tasks](#tasks)
  - [Projects](#projects)
  - [Labels](#labels)
  - [Comments](#comments)
  - [Sections](#sections)
  - [Files](#files)
  - [User](#user)
- [Error Handling](#error-handling)
- [Collections](#collections)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'todoist'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install todoist
```

## Quick Start

```ruby
require 'todoist'

# Initialize the client with your Todoist API token
client = Todoist::Client.new('your_api_token_here')

# Create a new task
task = client.task.add(content: 'Buy groceries', project_id: '123456789')

# Get all projects
projects = client.projects.all

# Mark task as complete
client.task.complete(id: task.id)
```

## Authentication

To use this SDK, you need a Todoist API token. You can obtain one by:

1. Going to [Todoist Settings](https://app.todoist.com/app/settings/integrations/developer)
2. Scrolling down to the "API token" section
3. Copying your API token

```ruby
client = Todoist::Client.new('your_api_token_here')
```

## Features

✅ **Complete API Coverage** - Supports all major Todoist API endpoints  
✅ **Intuitive Ruby API** - Clean, Ruby-like method names and conventions  
✅ **Entity Objects** - Rich objects with attribute access  
✅ **Collections** - Enumerable collections for easy iteration  
✅ **Error Handling** - Comprehensive error handling and validation  
✅ **File Uploads** - Support for file attachments  
✅ **Well Tested** - Comprehensive test coverage  
✅ **Ruby 3.0+** - Modern Ruby version support  

### Supported Resources

- **Tasks** - Create, read, update, delete, search, complete, and move tasks
- **Projects** - Manage projects and project hierarchy
- **Labels** - Create and manage labels for organization
- **Comments** - Add comments to tasks and projects
- **Sections** - Organize tasks within projects using sections
- **Files** - Upload and manage file attachments
- **User** - Access user profile information

## Usage

### Tasks

The task resource provides comprehensive task management capabilities:

```ruby
# Create a new task
task = client.task.add(
  content: 'Complete project proposal',
  description: 'Need to finish by end of week',
  project_id: '2203306141',
  labels: ['work', 'urgent'],
  priority: 4,
  due_string: 'tomorrow at 9am'
)

# Get all tasks
tasks = client.task.all
tasks.each do |task|
  puts "#{task.content} - Priority: #{task.priority}"
end

# Get tasks with label
urgent_tasks = client.task.all(label: 'work')

# Update a task
updated_task = client.task.update(
  id: task.id,
  content: 'Updated task content'
)

# Get a specific task
task = client.task.retrieve(id: '123456789')

# Search tasks
search_results = client.task.search(query: 'shopping')

# Complete a task
client.task.complete(id: task.id)

# Reopen a completed task
client.task.uncomplete(id: task.id)

# Move task to different project
client.task.move(id: task.id, project_id: '987654321')

# Get completed tasks by completion date
completed_tasks = client.task.completed_by_completion_date(
  from: '2024-01-01',
  to: '2024-01-31'
)

# Get completed tasks by due date
completed_by_due = client.task.completed_by_due_date(
  from: '2024-01-01',
  to: '2024-01-31'
)

# Delete a task
client.task.delete(id: task.id)
```

### Projects

Manage your project hierarchy and organization:

```ruby
# Get all projects
projects = client.projects.all

# Create a new project
project = client.projects.add(
  name: 'Website Redesign',
  color: 'blue',
  is_favorite: true
)

# Get a specific project
project = client.projects.retrieve(id: '123456789')

# Update a project
updated_project = client.projects.update(
  id: project.id,
  name: 'Updated Project Name',
  color: 'red'
)

# Delete a project
client.projects.delete(id: project.id)
```

### Labels

Create and manage labels for better task organization:

```ruby
# Get all labels
labels = client.label.all

# Create a new label
label = client.label.add(
  name: 'urgent',
  color: 'red'
)

# Get a specific label
label = client.label.retrieve(id: '123456789')

# Update a label
updated_label = client.label.update(
  id: label.id,
  name: 'high-priority',
  color: 'orange'
)

# Delete a label
client.label.delete(id: label.id)
```

### Comments

Add comments to tasks and projects for collaboration:

```ruby
# Add a comment to a task
comment = client.comment.add(
  content: 'This task is almost complete!',
  id: '123456789'
)

# Add a comment to a project
project_comment = client.comment.add(
  content: 'Project is on track',
  project_id: '987654321'
)

# Get all comments for a task
task_comments = client.comment.all(id: '123456789')

# Get all comments for a project
project_comments = client.comment.all(project_id: '987654321')

# Get a specific comment
comment = client.comment.retrieve(id: '123456789')

# Update a comment
updated_comment = client.comment.update(
  id: comment.id,
  content: 'Updated comment content'
)

# Delete a comment
client.comment.delete(id: comment.id)
```

### Sections

Organize tasks within projects using sections:

```ruby
# Get all sections
sections = client.section.all

# Create a new section
section = client.section.add(
  name: 'In Progress',
  project_id: '123456789'
)

# Get a specific section
section = client.section.retrieve(id: '123456789')

# Update a section
updated_section = client.section.update(
  id: section.id,
  name: 'Completed Tasks'
)

# Delete a section
client.section.delete(id: section.id)
```

### Files

Upload and manage file attachments:

```ruby
# Upload a file
uploaded_file = client.file.upload(file_path: '/path/to/your/file.pdf')

# Delete a file
client.file.delete(file_url: uploaded_file.file_url)
```

Attach file to project or comment:
```ruby
file = client.file.upload(file_path: '/path/to/your/file.pdf')
client.comment.add(
	content: 'Comment with attachment',
	project_id: '1234567890',
	attachment: file.to_h
)
```



### User

Access user profile information:

```ruby
# Get current user information
user = client.user.info

puts "User: #{user.full_name}"
puts "Email: #{user.email}"
puts "Premium: #{user.is_premium}"
puts "Timezone: #{user.tz_info.timezone}"
```

## Error Handling

The SDK provides comprehensive error handling for API errors:

```ruby
begin
  task = client.task.add(content: 'New task')
rescue Todoist::Error => e
  puts "API Error: #{e.message}"
end
```

Common error scenarios:
- Invalid API token
- Rate limiting
- Invalid request parameters
- Resource not found
- Network connectivity issues

## Collections

The SDK returns collections for list operations that implement Ruby's `Enumerable` interface:

```ruby
tasks = client.task.all

# Iterate through tasks
tasks.each do |task|
  puts task.content
end

# Use Enumerable methods
urgent_tasks = tasks.select { |task| task.priority == 4 }
task_contents = tasks.map(&:content)

# Check collection size
puts "Total tasks: #{tasks.count}"

# Access pagination info (if available)
puts "Next cursor: #{tasks.next_cursor}" if tasks.next_cursor
```

## Testing

The gem includes comprehensive test coverage using Minitest and WebMock. To run the tests:

```bash
$ bundle exec rake test
```

### Running Tests in Development

```bash
# Run all tests
$ rake test

# Run specific test file
$ ruby -Itest test/resources/task_resource_test.rb
```

## API Coverage

This SDK covers all major Todoist API v1 endpoints:

| Resource | Create | Read | Update | Delete | Additional Operations |
|----------|--------|------|--------|--------|-----------------------|
| Tasks | ✅ | ✅ | ✅ | ✅ | Complete, Search, Move, Get Completed |
| Projects | ✅ | ✅ | ✅ | ✅ | - |
| Labels | ✅ | ✅ | ✅ | ✅ | - |
| Comments | ✅ | ✅ | ✅ | ✅ | - |
| Sections | ✅ | ✅ | ✅ | ✅ | - |
| Files | ✅ | - | - | ✅ | Upload |
| User | - | ✅ | - | - | Get Profile |

## Requirements

- Ruby 3.0 or higher
- A valid Todoist API token

## Dependencies

This gem has minimal dependencies:
- `json` (standard library)
- `net/http` (standard library)
- `uri` (standard library)

Development dependencies:
- `minitest` for testing
- `rake` for task management
- `webmock` for HTTP request stubbing

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for your changes
4. Make your changes and ensure tests pass
5. Commit your changes (`git commit -am 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Create a Pull Request

### Development Setup

```bash
$ git clone https://github.com/yourusername/todoist-sdk.git
$ cd todoist-sdk
$ bundle install
$ bundle exec rake test
```

## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Support

- **Documentation**: [Todoist API Documentation](https://developer.todoist.com/rest/v1/)
- **Issues**: [GitHub Issues](https://github.com/msaami/todoist-sdk/issues)
- **Email**: mehrdadsaami@gmail.com

## Changelog

### v0.1.0
- Initial release
- Support for all major Todoist API endpoints
- Comprehensive test coverage
- Ruby 3.0+ support

---

Built with ❤️ for the Ruby community by [Mehrdad Sami](mailto:mehrdadsaami@gmail.com)
