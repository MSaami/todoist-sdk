require './lib/todoist/config'

module Todoist
  class Project

    def initialize(client)
      @client = client
    end

    def all
      @client.get_request(Todoist::Config::URLS[:projects])
    end

  end
end
