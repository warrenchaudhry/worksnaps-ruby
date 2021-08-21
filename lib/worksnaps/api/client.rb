# frozen_string_literal: true

module Worksnaps
  module Api
    class Client
      API_URL = "https://api.worksnaps.com/api"
      BASE_TOKEN = "gnNo5Vhs5cTsXJu3y466sCbTSJeZAYCyIT7ktVEx"
      BASE_PROJECT_ID = "18385"

      def initialize(token:)
        @token = token
      end

      def token
        @token || BASE_TOKEN
      end

      def auth_headers
        auth_hash(token: token)
      end

      def get(path)
        Request.execute_get(full_request_url(path), basic_auth: auth_headers)
      rescue StandardError => e
        raise Worksnaps::Error::ServerError.new(err_message: e.message)
      end

      def full_request_url(path)
        [API_URL, path].join
      end

      private

      def auth_hash(token: nil)
        puts "Using base token" if token.nil?
        token ||= Worksnaps::Base::BASE_TOKEN
        { username: token, password: "" }
      end
    end
  end
end
