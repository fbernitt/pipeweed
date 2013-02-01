require 'docile'

module Pipeweed
  class Dsl
    module Service
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      Service = Struct.new(:name, :depends_on, :start)
   
      class ServiceBuilder
        def name(name); @name = name; end
        def depends_on (name); @depends_on = name; end
        def start (&block); @start = block; end
        def build
          Service.new(@name, @depends_on, @start)
        end
      end
      
      module ClassMethods
        def create_service(&block)
          Docile.dsl_eval(ServiceBuilder.new, &block).build
        end
      end

    end
  end
end