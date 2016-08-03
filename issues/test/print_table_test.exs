defmodule PrintTableTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [column_max_width: 2,
                            column_widths: 2,
                            create_header: 2,
                            get_longer: 1,
                            create_separator: 2,
                            create_body: 3]

  test "column max width" do
    assert column_max_width(test_list, "number") == "101"
    assert column_max_width(test_list, "created_at") == "02/01/2016T12:34"
    assert column_max_width(test_list,"title") == "This issue was very serious and I was handled very quickly"
  end
  test "column max width for unknown column" do
    assert column_max_width(test_list, "karlo") == ""
  end
  test "column widths for list of responses" do
    assert column_widths(test_list, test_columns) == [3,16,0, 58]
  end
  test "create header" do
    assert create_header(test_columns,column_widths(test_list,test_columns)) == "|number|created_at      |unknown|title                                                     "
  end
  test "create separator" do
    assert create_separator(test_columns,column_widths(test_list,test_columns)) == "+------+----------------++----------------------------------------------------------"
  end
  test "create body" do
    assert create_body(test_columns,column_widths(test_list,test_columns),Enum.at(test_list,0)) == "|1     |01/01/2016      ||Very nice job you have!                                   "
  end
  test "get_longer" do
    assert get_longer({"karlo",2}) == 5
    assert get_longer({"number",10}) == 10
  end
  defp test_list do
    list = [%{"number" => 1,"created_at" => "01/01/2016", "title" => "Very nice job you have!"},
            %{"number" => 101, "created_at" => "02/01/2016T12:34", "title" => "This issue was very serious and I was handled very quickly"},
            %{"number" => 10, "created_at" => "03-01-2019", "title" => "Very short issue"}]
    list
  end
  defp test_columns do
    test_columns = ["number","created_at","unknown","title"]
    test_columns
  end
end
