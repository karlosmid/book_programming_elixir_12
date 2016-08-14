defmodule Issues.TableFormatter do
  def table_print issues,columns do
   header_column_lengths = column_widths(issues,columns)
   IO.puts create_header(columns,header_column_lengths)
   IO.puts create_separator(columns,header_column_lengths)
   issues
   |> Enum.map(fn(x) -> IO.puts(create_body(columns,header_column_lengths,x)) end)
 end
 def get_longer column_info do
   case {String.length(elem(column_info,0)),elem(column_info,1)} do
     {_,0} -> 0
     {x,y} when x > y -> x
     {_,y} -> y
   end
 end
 def create_separator(columns,header_column_lengths) do
   columns
   |> Enum.zip(header_column_lengths)
   |> Enum.map(fn(x) -> "+#{String.duplicate("-",get_longer(x))}" end)
   |> Enum.join
 end
 def create_body(columns,header_column_lengths,row) do
   columns
   |> Enum.zip(header_column_lengths)
   |> Enum.map(fn(x) -> "|#{String.pad_trailing(to_string(row[elem(x,0)]),get_longer(x))}" end)
   |> Enum.join
 end
 def create_header(columns,header_column_lengths) do
   columns
   |> Enum.zip(header_column_lengths)
   |> Enum.map(fn(x) -> "|#{String.pad_trailing(elem(x,0),get_longer(x))}" end)
   |> Enum.join
 end
 def column_widths issues,columns do
   columns
   |> Enum.map(fn(n) -> String.length(column_max_width(issues,n)) end)
 end
 def column_max_width list,name do
   list
   |> Enum.map(fn(x) -> to_string(x[name]) end)
   |> Enum.max_by(&String.length/1)
 end
end
