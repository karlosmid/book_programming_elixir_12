defmodule StackTest do
  use ExUnit.Case
  setup do
    :sys.replace_state(Stack.Server, fn {_old_state,pid} -> {[1,2,3,4],pid} end)
    :ok
  end
  test "pop" do
    assert Stack.Server.pop == 1
  end
  #is it possible to assert termination
  test "empty stack" do
    Stack.Server.pop
    Stack.Server.pop
    Stack.Server.pop
    Stack.Server.pop
    assert_raise ArgumentError, fn ->
      Stack.Server.pop
    end
  end
  test "push" do
    assert Stack.Server.push(5) == :ok
    {stack,pid} = :sys.get_state(Stack.Server)
    assert stack == [5,1,2,3,4]
  end
end
