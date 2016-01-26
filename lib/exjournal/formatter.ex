defmodule ExJournal.Formatter do
  
  use Timex

  def print_table(table) do
    table
      |> Enum.map(&format_row/1)
      |> print 
  end

  def format_row({timestamp, body}) do
    date_str = Date.from(timestamp, :secs)
                |> DateFormat.format!("%a, %d %b %Y %H:%M:%S", :strftime)
    [:magenta, date_str, :white, " -> ", to_string(body)]
  end
  
  #[:cyan, "Hello, ", :white,"world!"] |> IO.ANSI.format |> IO.puts
  def print(table) do
    table |> Enum.each(&(&1 |> IO.ANSI.format |> IO.puts))
  end


end
