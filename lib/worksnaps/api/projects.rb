# frozen_string_literal: true

module Worksnaps
  module Api
    class Projects < Base
      class << self
        def all
          execute_with_base_token('/projects.xml')
        end
      end
    end
  end
end