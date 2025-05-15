module Todoist
  # The Collection class is responsible for managing a collection of entities.
  class Collection
    include Enumerable

    attr_reader :data

    def initialize(response, entity_class:)
      @data = response['results'].map { |item| entity_class.new(item) }
    end

    def each(&block)
      @data.each(&block)
    end
  end
end
