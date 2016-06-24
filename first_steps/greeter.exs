defmodule Greeter do
  def for(name,greeting) do
    fn 
      (^name) -> "#{greeting} #{name}"
      _ -> "I do not know you"
    end
  end
end
mr_karlo = Greeter.for("Karlo", "Bok!")
IO.puts mr_karlo.("Karlo")
IO.puts mr_karlo.("Bestija")
