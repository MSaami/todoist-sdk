# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-01-01

### Added
- Initial release of the Todoist SDK for Ruby
- Support for all major Todoist API endpoints:
  - Tasks (create, read, update, delete, search, complete, move)
  - Projects (create, read, update, delete)
  - Labels (create, read, update, delete)
  - Comments (create, read, update, delete)
  - Sections (create, read, update, delete)
  - Files (upload, delete)
  - User (profile information)
- Comprehensive test coverage with Minitest and WebMock
- Entity objects with attribute access using OpenStruct
- Collections with Enumerable support
- Error handling for API responses
- Ruby 3.0+ support
- MIT license

### Technical Details
- Uses standard library HTTP client (net/http)
- Minimal dependencies for production use
- Comprehensive documentation and examples
- RESTful API design patterns
