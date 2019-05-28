defmodule Minesweeper.MixProject do
  use Mix.Project

  def project do
    [
      app: :minesweeper,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      escript: [main_module: Minesweeper]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_app_info, "~> 0.3.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:junit_formatter, "~> 3.0", only: [:test]},
      {:mox, "~> 0.5", only: :test}
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
