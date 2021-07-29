# frozen_string_literal: true

module Worksnaps
  class Collection
    OBJECT_KLASS = {
      'users' => Worksnaps::User,
      'projects' => Worksnaps::Project
    }

    attr_reader :resources, :root, :object_collections
    def initialize(root, resources)
      @root = root
      @resources = resources
      @object_collections = []
    end

    def call
      items.each do |item|
        object_collections << to_object(item)
      end
      self.object_collections
    end

    def self.transform_to_objects(root, resources)
      new(root, resources).call
    end

    private

    def items
      @items = resources
      @items = [@items] if resources.is_a?(Hash)
      @items
    end

    def to_object(hash)
      OBJECT_KLASS[root].new(hash)
    end
  end
end