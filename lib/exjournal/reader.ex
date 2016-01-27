defmodule ExJournal.Reader do
  
  use Timex
  require Logger

  @base_path Application.get_env(:exjournal, :base_path)
 
  def yesterday() do

    # FIX: This code should be on a guard clause? 
    if !File.exists?(@base_path) do
      File.mkdir(@base_path)
    end

    DirWalker.stream(@base_path)
      |> Stream.map(&parse_path/1)
      |> Stream.filter(&yesterday_filter/1)
      |> Stream.map(&read_file_contents/1)
      |> Enum.to_list
  end

  def today() do

    # FIX: This code should be on a guard clause? 
    if !File.exists?(@base_path) do
      File.mkdir(@base_path)
    end

    DirWalker.stream(@base_path)
      |> Stream.map(&parse_path/1)
      |> Stream.filter(&today_filter/1)
      |> Stream.map(&read_file_contents/1)
      |> Enum.to_list
  end
  
  #.DS_Store or any other files breaks the whole thing!
  # returns:
  # #{ 1453507200, "/vagrant/exjournal/.exjournal/1453593600.txt" }
  def parse_path (path) do
  
    file_name = Path.basename(path, ".txt")
    unix_tuple =  Integer.parse(file_name)
    unix_date = elem(unix_tuple, 0)
    {unix_date, path}

  end

  
  def yesterday_filter({timestamp, _ }) do
    
    beginning_of_day = Date.now |> Date.beginning_of_day
    yesterday = beginning_of_day |> Date.subtract(Time.to_timestamp(1, :days))
    file_date = Date.from(timestamp, :secs)

    file_date >= yesterday && file_date < beginning_of_day
  
  end

  def today_filter({timestamp, _ }) do
    
    beginning_of_day = Date.now |> Date.beginning_of_day
    file_date = Date.from(timestamp, :secs)

    file_date >= beginning_of_day
  
  end

  def read_file_contents({timestamp, filepath}) do
    {timestamp, File.read!(filepath)}
  end



end

