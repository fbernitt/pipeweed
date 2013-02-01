require 'docile'

module Pipeweed
  class Dsl
    module Repository
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      Repository = Struct.new(:name, :scm, :url, :branch)
   
      class RepositoryBuilder
        def scm(type=:git); @scm = type; end
        def url(u=""); @url = u; end
        def branch(name = :default); @branch = name; end
        def build
          Repository.new('undefined', @scm, @url, @branch)
        end
      end
      
      module ClassMethods
        def create_repository(&block)
          Docile.dsl_eval(RepositoryBuilder.new, &block).build
        end
      end
      
    end
  end
end