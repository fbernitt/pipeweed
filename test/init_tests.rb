require 'rubygems'
require 'bundler/setup'

require 'test/unit'
require 'mocha/setup'

module TestExtensions
end

class Test::Unit::TestCase
  include TestExtensions
end
