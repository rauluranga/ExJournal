defmodule ExJournal.CLI do

    @moduledoc """
    Handle the command line parsing and dispatch to 
    the various functions that end up generating a 
    table of last _n_ jornals in a given date
    """
	def main(argv) do
		argv 
		 |> parse_args
		 |> process
	end

	@doc """
    'argv' can be:
    -h or --help, wich returns :help.
    -f today or --from today, wich returns :today
    -f yesterday or --from yesterday, wich returns :yesterday.
    Otherwise is the jornal message to be saved.
    """
	def parse_args(argv) do
		parse = OptionParser.parse(argv, switches: [help: :boolean, from: :string], aliases: [ h: :help, f: :from])
		case parse do
		  { [help: true], _, _ } -> :help
		  { [from: "today"], _, _ } -> :today
		  { [from: "yesterday"], _, _ } -> :yesterday
		  { _, [message], _ } -> { message }
		  _ -> :help
		end
	end

	def process(:help) do
		IO.puts """
			usage: exjournal <message>
			       exjournal --from <today|yesterday>
		"""
		System.halt(0)
	end

	def process(:today) do
        ExJournal.Reader.today
          |> ExJournal.Formatter.print_table
    end

	def process(:yesterday) do
          ExJournal.Reader.yesterday  
            |> ExJournal.Formatter.print_table
	end

	def process({ message }) do
		ExJournal.Writter.save(message)
			|> proccess_file
	end

	def proccess_file({:ok, file_path}) do
		IO.puts "Journal successfully saved at #{Path.basename(file_path)}"
		System.halt(0)
	end

	def proccess_file({:error, reason}) do
		IO.puts "Something wrong happened"
		IO.puts "Error: #{reason}"
		System.halt(0)
	end

end
