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
  def handle_request(%{method: :GET, path: [short_string]}, _state) do
    path = "/" <> short_string

    case Urler.resolve(path) do
      {:ok, url} ->
        301
        |> response()
        |> set_header("location", url)
        |> set_body("")

      :not_found ->
        404
        |> response()
        |> set_header("content-type", "application/json")
        |> set_body(Poison.encode!(%{message: "Not found"}))
    end
  end

  def handle_request(%{method: :POST, path: ["urls"]} = request, _state) do
    with body <- request.body,
         {:ok, params} <- Poison.decode(body),
         {:ok, url} <- Map.fetch(params, "url"),
         {:ok, short_url} <- Urler.shorten(url) do
      response_body = %{url: url, short: short_url} |> Poison.encode!()

      201
      |> response()
      |> set_header("content-type", "application/json")
      |> set_body(response_body)
    else
      _error ->
        400
        |> response()
        |> set_header("content-type", "application/json")
        |> set_body(Poison.encode!(%{message: "Bad request"}))
    end
  end

  def handle_request(_catch_all, _state) do
    404
    |> response()
    |> set_header("content-type", "application/json")
    |> set_body(Poison.encode!(%{message: "Not found"}))
  end
end
