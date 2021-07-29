# frozen_string_literal: true

module Worksnaps
  module Api
    class Request
      def self.execute_get(url, headers = {})
        HTTParty.get(url, headers)
      end
    end
  end
end