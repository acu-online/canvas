defmodule Canvas.MixProject do
  use Mix.Project

  def project do
    [
      app: :canvas,
      version: "0.0.1",
      elixir: "~> 1.8",
      description: "Elixir client for the Canvas LMS API",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:poison, "~> 4.0"},
      {:exvcr, "~> 0.10", only: :test},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "*.md"],
      maintainers: ["John Kaczmarek"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/acu-dev/canvas",
        "API docs" => "https://canvas.instructure.com/doc/api/index.html"
      }
    ]
  end
end
