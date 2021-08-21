# frozen_string_literal: true

require "httparty"
require "uri"

require_relative "worksnaps/base"
require_relative "worksnaps/errors"
require_relative "worksnaps/project"
require_relative "worksnaps/user"
require_relative "worksnaps/version"

require_relative "worksnaps/api/base"
require_relative "worksnaps/api/client"
require_relative "worksnaps/api/request"
require_relative "worksnaps/api/users"
require_relative "worksnaps/api/projects"

require_relative "worksnaps/collection"

module Worksnaps
  # Your code goes here...
end
