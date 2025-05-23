# frozen_string_literal: true

module Todoist
  # The FileResource class is responsible for managing file uploads in Todoist.
  class FileResource < BaseResource
    def delete(file_url:)
      @client.delete_request(Todoist::Config::URLS[:delete_file].gsub(':file_url', file_url))
      true
    end

    def upload(file_path:)
      Entities::File.new @client.upload_request(Todoist::Config::URLS[:upload_file],
                                                file_path: file_path)
    end
  end
end
