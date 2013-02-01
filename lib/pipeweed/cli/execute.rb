
require 'pipeweed/dsl'

module Pipeweed
  class Cli
    module Execute
      def self.included(base) #:nodoc:
        base.extend(ClassMethods)
      end

      module ClassMethods
        def execute
          parse(ARGV).execute!
        end

      end
      
      def execute!
        dsl = Dsl.new
        dsl.load_default_recipe
      end
    
    end
  end
end