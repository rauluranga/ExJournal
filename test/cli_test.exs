defmodule CLITest do
  use ExUnit.Case
  doctest Journal

  import Journal.CLI, only: [ parse_args: 1 ]

  test ":help returned by parsing -h and --help options" do
    assert parse_args(["--help", "foo"]) == :help
    assert parse_args(["-h", "foo"]) == :help
  end

end
