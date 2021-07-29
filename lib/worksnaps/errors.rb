# frozen_string_literal: true

module Worksnaps
  module Error
    class BaseError < StandardError
      attr_reader :err_message

      def initialize(err_message: nil)
        @err_message = err_message
        super
      end

      def message
        "Sorry! Error encountered." if err_message.nil?
      end
    end

    class Unauthorized < BaseError
      def message
        "You must be authorized to view this resource." if err_message.nil?
      end
    end

    class BadRequest < BaseError; end

    class Forbidden < BaseError; end

    class ServerError < BaseError; end

    class ArgumentError < BaseError; end
  end
end
