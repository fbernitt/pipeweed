require 'docile'

module Pipeweed
  class Dsl
    module Host
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      Host = Struct.new(:fqdn, :runs)
   
      class HostBuilder
        def fqdn(name); @name = name; end
        def runs(services) @runs = services; end
        def build
          Host.new(@fqdn, @runs)
        end
      end
      
      module ClassMethods
        def create_host(&block)
          Docile.dsl_eval(HostBuilder.new, &block).build
        end
      end
      
    end
  end
end