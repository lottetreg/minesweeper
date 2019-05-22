defmodule Minesweeper.MixProject do
  use Mix.Project

  def project do
    [
      app: :minesweeper,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:junit_formatter, "~> 3.0", only: [:test]},
      {:ex_app_info, "~> 0.3.0"}
    ]
  end

  defp package do
    [
      description: "A minesweeper game",
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/lottetreg/minesweeper"},
      source_url: "https://github.com/lottetreg/minesweeper"
    ]
  end
end
