defmodule Journal.Writter do
    
    use Timex
	require Logger
	
	@base_path Path.expand("/vagrant/journal/.journal")

	def save(message) do

	   	if !File.exists?(@base_path) do
	   	  File.mkdir(@base_path)
	   	end

	   	Logger.info "Writing '#{message}' into #{file_path}"
		
		file = file_path
		File.write(file, message)
			|> handle_response(file)
	end
    
	def file_path() do
		Path.join([@base_path, "#{Date.now(:secs)}.txt"])
	end

	defp handle_response(:ok, file_path) do
		{:ok, file_path}
	end

	defp handle_response({:error, _}, file_path) do
		{:error, "a component of the file name does not exist or is not a directory"}
	end

end