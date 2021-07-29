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
          set_to_object(res.parsed_response)
        else
          puts "Error code %s" % res.code
          throw_error(res.code, res)
        end
      end

      def self.execute(token, path)
        new(token: token).execute_get(path)
      end

      def self.execute_with_base_token(path)
        base_token = ENV['WS_API_TOKEN']
        new(token: base_token).execute_get(path)
      end

      private

      def set_to_object(response)
        root = response.keys.first
        case root
        when 'user'
          Worksnaps::User.new(response["user"])
        when 'users'
          set_to_object_collections('users', response["users"]['user'])
        when 'projects'
          set_to_object_collections('projects', response["projects"]['project'])
        end

      end

      def set_to_object_collections(root, items)
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
        err_class = case code
                    when 400
                      Worksnaps::Error::BadRequest
                    when 401
                      Worksnaps::Error::Unauthorized
                    when 403
                      Worksnaps::Error::Forbidden
                    else
                      Worksnaps::Error::ServerError
                    end
        raise err_class.new(err_message: err_message)
      end
    end
  end
end