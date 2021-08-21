# frozen_string_literal: true

module Worksnaps
  class Project < Base
    attr_reader :id, :name, :status

    def initialize(attrs)
      @id, @name, @status = attrs.slice("id", "name", "status").values
      super
    end

    class << self
      def all
        Worksnaps::Api::Projects.all
      end
    end
  end
end
