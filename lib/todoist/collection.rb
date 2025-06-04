# frozen_string_literal: true

module Todoist
  # The Collection class is responsible for managing a collection of entities.
  class Collection
    include Enumerable

    attr_reader :data, :next_cursor

    def initialize(response, entity_class:, main_key: 'results')
      @data = response[main_key].map { |item| entity_class.new(item) }
      @next_cursor = response['next_cursor']
    end

    def each(&block)
      @data.each(&block)
    end
  end
end
