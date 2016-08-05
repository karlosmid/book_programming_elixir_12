defmodule Issues.CLI do
 @default_count 4
 @moduledoc """
 Handle the command line parsing and the dispatch to
 various functions that end up generating a
 table of the last _n_ issues in a github project
 """
 def main(argv) do
   argv
   |> parse_args
   |> process
 end
 @doc """
 `argv` can be -h or --help, which returns :help.
 Otherwise it is a github username, project name and (optionally)
 the numbers of entries to format.
 Return a tuple of `{user, project, count}`, or `:help`
 if help was given.
 """
 def parse_args(argv) do
   parse = OptionParser.parse(argv, switches: [help: :boolean],
   aliases: [h: :help])
   case parse do
     {[help: true],_,_} -> :help
     {_,[user,project,count],_} -> {user,project,String.to_integer(count)}
     {_,[user,project],_} -> {user,project,@default_count}
     _ -> :help
   end
 end
 def process(:help) do
   IO.puts """
   usage: issues <user> <project> [count | #{@default_count}]
   """
   System.halt(0)
 end
 def process({user,project,count}) do
   Issues.GithubIssues.fetch(user,project)
   |> decode_response
   |> convert_to_list_of_maps
   |> sort_into_ascending_order
   |> Enum.take(count)
   |> table_print(["number", "created_at", "title"])
 end
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
 def sort_into_ascending_order(list_of_issues) do
   Enum.sort list_of_issues, fn i1,i2 -> i1["created_at"] <= i2["created_at"] end
 end
 def decode_response({:ok, body}), do: body
 def decode_response({:error, error}) do
   {_,message} = List.keyfind(error,"message",0)
   IO.puts "Error fetching from Github: #{message}"
   System.halt(2)
 end
 def convert_to_list_of_maps(list) do
   list
   |> Enum.map(&Enum.into(&1, Map.new))
 end
end
