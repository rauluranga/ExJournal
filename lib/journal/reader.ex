defmodule Journal.Reader do
  
  use Timex
  require Logger

  @base_path Path.expand("/vagrant/journal/.journal")
 
  def yesterday() do
    paths = DirWalker.stream(@base_path)
      |> Stream.map(&parse_path/1)
      |> Stream.filter(&filter_yesterday/1)
      |> Enum.to_list
  end
  
  #.DS_Store files breaks the whole thing!

  def parse_path (path) do
  
    file_name = Path.basename(path, ".txt")
    
    unix_tuple =  Integer.parse(file_name)

    #IO.puts "file_name: #{file_name}"
    #IO.inspect unix_tuple

    unix_date = elem(unix_tuple, 0)
    erlang_date = date_from_timestamp(unix_date)
  
    {erlang_date, path}

  end

  def date_from_timestamp(timestamp) do
    timestamp 
      |> Date.from(:secs)
      |> DateConvert.to_erlang_datetime
  end

  #{{{2016, 1, 24}, {0, 0, 0}}, "/vagrant/journal/.journal/1453593600.txt"}
  
  def filter_yesterday({{{year,month,day},_},_}) do
    year == 2016 && month == 1 && day == 24  
    #match?({year, month, day}, {2016, 1, 24})
  end

end

