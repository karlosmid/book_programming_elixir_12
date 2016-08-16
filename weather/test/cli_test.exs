defmodule CliTest do
  use ExUnit.Case
  doctest Weather
  import Weather.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end
  test "one value returned if one value given" do
    assert parse_args(["country_code"]) == {"country_code"}
  end
  test "no arguments" do
    assert parse_args([]) == :help
  end
end
