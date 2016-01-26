defmodule ExJournal.Formatter do
  
  use Timex

  def print_table(table) do
    table
      |> Enum.map(&format_row/1)
      |> print 
  end

  @doc """
  Returns named ANSI sequences, this data is latter used by IO.ANSI.format 
  ## Examples
      iex> ExJournal.Formatter.format_row({1453849666, "Hello World"})
      [:magenta, "Tue, 26 Jan 2016 23:07:46", :white, " -> ", "Hello World"]
  """
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
