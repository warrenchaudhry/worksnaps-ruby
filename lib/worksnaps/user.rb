# frozen_string_literal: true

module Worksnaps
  class User < Base
    attr_reader :id, :login, :first_name, :last_name, :email, :timezone_id, :is_in_daylight_time, :api_token,
                :timezone_name

    def initialize(attrs)
      @id = attrs["id"]
      @login = attrs["login"]
      @first_name = attrs["first_name"]
      @last_name = attrs["last_name"]
      @email = attrs["email"]
      @timezone_id = attrs["timezone_id"]
      @is_in_daylight_time = attrs["is_in_daylight_time"]
      @api_token = attrs["api_token"]
      @timezone_name = attrs["timezone_name"]
      super
    end

    class << self
      def find_by_token(token)
        Worksnaps::Api::Users.find(token)
      end

      def all
        Worksnaps::Api::Users.all
      end
    end

    def projects
      Project.all
    end
  end
end
