defmodule Journal.CLI do

	def main(argv) do
		argv 
		 |> parse_args
		 |> process
	end

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
			usage: journal <message>
		"""
		System.halt(0)
	end

	def process(:today) do
        Journal.Reader.today
          |> Journal.Formatter.print_table
    end

	def process(:yesterday) do
          Journal.Reader.yesterday  
            |> Journal.Formatter.print_table
	end

	def process({ message }) do
		Journal.Writter.save(message)
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
