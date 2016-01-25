defmodule Journal.CLI do

	def main(argv) do
		argv 
		 |> parse_args
		 |> process
	end

	def parse_args(argv) do
		parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [ h: :help])
		case parse do
		  { [help: true], _, _ } -> :help
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

	def process({ message }) do
		Journal.JournalWritter.write(message)
	end

end