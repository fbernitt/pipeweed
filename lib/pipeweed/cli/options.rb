module Pipeweed
  class Cli
    module Options
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        # Return a new CLI instance with the given arguments pre-parsed and
        # ready for execution.
        def parse(args)
          cli = new(args)
          cli.parse_options!
          cli
        end
      end
      
      # The hash of (parsed) command-line options
      attr_reader :options
      
      def parse_options! #:nodoc:
      end
    end
  end
end