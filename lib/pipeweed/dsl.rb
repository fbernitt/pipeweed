require 'pipeweed/dsl/repository'
require 'pipeweed/dsl/service'
require 'pipeweed/dsl/host'
require 'pipeweed/dsl/parser'

module Pipeweed
  class Dsl
    attr_reader :load_paths
    
    include Repository, Service, Host
    
     def load_default_recipe
       parser = Parser.new
       parser.load_default_recipe
     end
  end
end