defmodule UrlerWeb.Application do
  @moduledoc """
  This is the main entry point of the UrlerWeb application
  """

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: UrlerWeb.Supervisor]
    Supervisor.start_link(children(Mix.env()), opts)
  end

  defp children(:test) do
    []
  end

  defp children(_) do
    [
      UrlerWeb.Server
    ]
  end
end
