module Todoist
  class BaseResource
    def initialize(client)
      @client = client
    end

    def url(key)
      Todoist::Config::URLS[key]
    end
  end
end

