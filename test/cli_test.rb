require "init_tests"

require 'pipeweed/cli'

class Cli_Test < Test::Unit::TestCase
  def test_options_ui_and_help_modules_should_integrate_successfully_with_configuration
    cli = Pipeweed::Cli.parse(%w(-T -x -X))
    cli.expects(:puts).at_least_once
#    cli.execute!
  end
end
