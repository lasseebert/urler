defmodule Urler do
  @moduledoc """
  A URL shortener application
  """

  alias Urler.Encoder
  alias Urler.Store

  @doc """
  Shortens a URL and returns the path of the short_url.
  """
  @spec shorten(String.t()) :: {:ok, String.t()}
  def shorten(url) do
    {:ok, id} = Store.put(url)

    short_url =
      id
      |> Encoder.encode()
      |> full_short_url()

    {:ok, short_url}
  end

  @doc """
  Resolves a short URL to a URL
  """
  @spec resolve(String.t()) :: {:ok, String.t()} | :not_found | :invalid
  def resolve(short_url) do
    with {:ok, short_string} <- short_url_to_encoded_id(short_url),
         {:ok, id} <- Encoder.decode(short_string),
         {:ok, url} <- Store.fetch(id) do
      {:ok, url}
    else
      :not_found -> :not_found
      :error -> :invalid
    end
  end

  defp full_short_url(short_string) do
    "/" <> short_string
  end

  defp short_url_to_encoded_id("/" <> short_string) do
    {:ok, short_string}
  end

  defp short_url_to_encoded_id(_), do: :error
end
