defmodule UrlerWeb.Server do
  @moduledoc """
  Ace web server
  """

  use Ace.HTTP.Service, port: 8080, cleartext: true

  def child_spec(state) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [state]}
    }
  end

  @impl Raxx.Server
  def handle_request(%{method: :GET, path: []}, _state) do
    response(:ok)
    |> set_header("content-type", "text/plain")
    |> set_body("Hello, World!")
  end
end
