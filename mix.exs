defmodule Crud.MixProject do
  use Mix.Project

  def project do
    [
      app: :crud,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Crud.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.1.2"},
      {:plug, "~> 1.4.3"},
      {:cors_plug, "~> 1.2"},
      {:poison, "~> 3.1"}
    ]
  end
end
