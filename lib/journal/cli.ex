defmodule Journal.CLI do

	def main(argv) do
		parse_args(argv)
	end

	def parse_args(argv) do
		parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [ h: :help])
		case parse do
		  { [help: true], _, _ } -> :help
		  { _, [message], _ } -> { message }
		end
	end

end