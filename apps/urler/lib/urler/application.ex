defmodule Urler.Application do
  @moduledoc """
  This is the main entry point of the Urler application
  """

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Urler.Supervisor]
    Supervisor.start_link(children(Mix.env()), opts)
  end

  defp children(:test) do
    []
  end

  defp children(_) do
    [
      Urler.Store
    ]
  end
end
