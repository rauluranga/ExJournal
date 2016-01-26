defmodule ExJournal.Mixfile do
  use Mix.Project

  def project do
    [app: :exjournal,
     version: "0.0.1",
     elixir: "~> 1.1",
     escript: escript_config,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :tzdata]]
  end

  def escript_config do
   [main_module: ExJournal.CLI]
  end
  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:timex, "~> 1.0.0"}, 
      {:tzdata, "== 0.1.8", override: true},
      {:dir_walker, "~> 0.0.6"}
    ]
  end
end
