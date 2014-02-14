# coding: utf-8
require "tekido/methods/percentage"
require "tekido/methods/boolean"
require "tekido/methods/numeric"
require "tekido/methods/array"
require "tekido/methods/date"
require "tekido/methods/string"

module Tekido
  module Methods
    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
