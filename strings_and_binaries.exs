defmodule StringsAndBinaries do
  def contains_all_ascii_printables([h|_]) when h < ?\s or h > ?~, do: false
  def contains_all_ascii_printables([_|t]), do: contains_all_ascii_printables(t)
  def contains_all_ascii_printables([]), do: true
  def anagram?(word1,word2), do: _anagram(prepare_words(word1) -- prepare_words(word2)) and _anagram(prepare_words(word2) -- prepare_words(word1))
  def prepare_words(words), do: words |> List.to_string |> String.replace(" ","") |> String.upcase |> String.to_charlist
  defp _anagram([]), do: true
  defp _anagram(_), do: false
  def calculate(expression) do
    case Regex.named_captures(~r/(?<first>[123456789]\d*)\s*(?<operand>[\+-\\*\/])\s*0*(?<second>[123456789]\d*)/, expression) do
      %{"first" => a, "operand" => "+", "second" => b} ->
        elem(Integer.parse(a),0) + elem(Integer.parse(b),0)
      %{"first" => a, "operand" => "-", "second" => b} ->
        elem(Integer.parse(a),0) - elem(Integer.parse(b),0)
      %{"first" => a, "operand" => "*", "second" => b} ->
        elem(Integer.parse(a),0) * elem(Integer.parse(b),0)
      %{"first" => a, "operand" => "/", "second" => b} ->
        elem(Integer.parse(a),0) / elem(Integer.parse(b),0)
      %{"first" => _, "operand" => non_support, "second" => _} ->
        raise "Not supported operand '#{non_support}'"
      _ -> raise "Not parsable input"
    end
  end
  def center(list), do: _center(Enum.sort_by(list,&String.length/1))
  defp _center(sorted_by_length) do
    longest = String.length(Enum.at(sorted_by_length,-1))
    sorted_by_length |> Enum.each(fn(x) -> IO.puts String.pad_leading(x,_calc_pad(longest,String.length(x))) end)
  end
  defp _calc_pad(longest_length,current_length), do: round(Float.ceil(longest_length/2) - Float.ceil(current_length/2) + current_length)
  def capitalize_sentences(input)  do
    input |> String.split(". ") |> Enum.map(&String.capitalize/1) |> Enum.join(". ")
  end
  def read_orders(file_name) do
    {:ok, data} = File.read(file_name)
    data_list = Enum.drop(String.split(data,"\n"),-1)
    header = String.split(Enum.at(data_list,0),",") |> Enum.map(&String.to_atom/1)
    data_list |> Enum.drop(1) |> Enum.map(&_transform/1) |> Enum.map(fn(x) -> Enum.zip(header,x) end)
  end
  defp _transform(data) do
    data_as_list = String.split(data,",")
    [String.to_integer(Enum.at(data_as_list,0)),String.to_atom(String.replace(Enum.at(data_as_list,1),":","")),String.to_float(Enum.at(data_as_list,2))]
  end
end
