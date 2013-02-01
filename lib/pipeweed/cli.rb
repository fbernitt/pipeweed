
require 'pipeweed/cli/execute'
require 'pipeweed/cli/options'

module Pipeweed
  class Cli
    attr_reader :args
    
    def initialize(args)
      @args = args.dup
      $stdout.sync = true # so that Net::SSH prompts show up
    end
    
    include Execute, Options
  end
end
