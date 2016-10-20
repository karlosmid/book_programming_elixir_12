defmodule StackSupervisorTest do
  use ExUnit.Case
  doctest Stack.Supervisor
  import Stack.Supervisor
  test "the env" do
    assert Application.get_env(:stack_supervisor, :initial_stack) == [1,2,3,4]
  end
end
