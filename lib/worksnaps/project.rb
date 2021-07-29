# frozen_string_literal: true

module Worksnaps
  class Project < Base
    attr_reader :id, :name, :description, :bill_type, :fixed_fee, :status

    def initialize(attrs)
      @id = attrs["id"]
      @name = attrs["name"]
      @description = attrs["description"]
      @bill_type = attrs["bill_type"]
      @fixed_fee = attrs["fixed_fee"]
      @status = attrs["@status"]
      super
    end

    class << self
      def all
        Worksnaps::Api::Projects.all('')
      end
    end
  end
end
