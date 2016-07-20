defmodule TaxRate do
  def test_orders do
   [[id: 123, ship_to: :NC, net_amount: 100.0],
   [id: 124, ship_to: :OK, net_amount: 35.5],
   [id: 125, ship_to: :TX, net_amount: 24.0],
   [id: 126, ship_to: :TX, net_amount: 44.8],
   [id: 127, ship_to: :NC, net_amount: 25.0],
   [id: 128, ship_to: :MA, net_amount: 10.0],
   [id: 129, ship_to: :CA, net_amount: 102.0],
   [id: 130, ship_to: :CA, net_amount: 50.0]]
  end
  def test_rates do
    [NC: 0.075, TX: 0.08]
  end
  def calculate(rate,orders), do: calculate_have(rate,orders) ++ calculate_have_not(rate,orders)
  def calculate_have_not(rate,orders), do: for y <- orders, List.keyfind(rate,y[:ship_to],0) == nil, do: Keyword.put(y, :total_amount, y[:net_amount])
  def calculate_have(rate,orders), do: for x <- rate, y <- orders, elem(x,0) == y[:ship_to], do: Keyword.put(y, :total_amount, y[:net_amount] * (1 + elem(x,1)))
end
