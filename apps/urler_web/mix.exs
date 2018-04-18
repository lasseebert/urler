defmodule UrlerWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :urler_web,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {UrlerWeb.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ace, "~> 0.15"},
      {:poison, "~> 3.1"},
      {:urler, in_umbrella: true}
    ]
  end
end
