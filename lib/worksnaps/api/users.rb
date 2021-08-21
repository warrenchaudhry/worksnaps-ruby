# frozen_string_literal: true

module Worksnaps
  module Api
    class Users < Base
      PATHS = {
        me: "/me.xml",
        all: "/users.xml"
      }.freeze

      class << self
        def find(token)
          execute(token, PATHS[:me])
        end

        def all
          execute_with_base_token(PATHS[:all])
        end
      end
    end
  end
end
