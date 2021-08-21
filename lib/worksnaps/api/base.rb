# frozen_string_literal: true

module Worksnaps
  module Api
    class Base
      attr_reader :token

      def initialize(token:)
        @token = token
      end

      def execute_get(path)
        res = client.get(path)
        if res.code == 200
          to_object(res.parsed_response)
        else
          puts "-- Error code: #{res.code} --"
          throw_error(res.code, res)
        end
      end

      def self.execute(token, path)
        new(token: token).execute_get(path)
      end

      def self.execute_with_base_token(path)
        base_token = ENV["WS_API_TOKEN"]
        new(token: base_token).execute_get(path)
      end

      private

      def to_object(response)
        root = response.keys.first
        case root
        when "user"
          Worksnaps::User.new(response["user"])
        when "users"
          to_object_collections("users", response["users"]["user"])
        when "projects"
          to_object_collections("projects", response["projects"]["project"])
        end
      end

      def to_object_collections(root, items)
        Worksnaps::Collection.transform_to_objects(root, items)
      end

      def client
        Client.new(token: token)
      end

      def throw_error(code, message_hash)
        err_message = begin
          message_hash["reply"]["error_string"]
        rescue StandardError
          nil
        end
        err_class = err_class_by_code(code)
        raise err_class.new(err_message: err_message)
      end

      def err_class_by_code(code)
        error_mappings.keys.include?(code) ? error_mappings[code] : Worksnaps::Error::ServerError
      end

      def error_mappings
        {
          400 => Worksnaps::Error::BadRequest,
          401 => Worksnaps::Error::Unauthorized,
          403 => Worksnaps::Error::Forbidden,
          404 => Worksnaps::Error::NotFound
        }
      end
    end
  end
end
