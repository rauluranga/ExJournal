defmodule CLITest do
  use ExUnit.Case
  doctest ExJournal

  import ExJournal.CLI, only: [ parse_args: 1 ]

  test ":help returned by parsing -h and --help options" do
    assert parse_args(["--help", "foo"]) == :help
    assert parse_args(["-h", "foo"]) == :help
  end

  test ":today returned by parsing '--from today'" do
    assert parse_args(["--from", "today"]) == :today
    assert parse_args(["-f", "today"]) == :today
  end

  test ":yesterday returned by parsing '--from yesterday'" do
    assert parse_args(["--from", "yesterday"]) == :yesterday
    assert parse_args(["-f", "yesterday"]) == :yesterday
  end

  test "One value is returned if one is give" do
  	assert parse_args(["lorem ipsum"]) == {"lorem ipsum"}
  end

end
