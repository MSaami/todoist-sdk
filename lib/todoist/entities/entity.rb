# frozen_string_literal: true

module Todoist
  module Entities
    # The Entity class is a base class for all entities in the Todoist API.
    class Entity < OpenStruct
      def initialize(attributes)
        super to_o(attributes)
      end

      def to_o(obj)
        if obj.is_a?(Hash)
          OpenStruct.new(obj.map { |key, val| [key, to_o(val)] }.to_h)
        elsif obj.is_a?(Array)
          obj.map { |o| to_o(o) }
        else # Assumed to be a primitive value
          obj
        end
      end
    end
  end
end
