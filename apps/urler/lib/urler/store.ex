defmodule Urler.Store do
  @moduledoc """
  Stores strings on incrementing integer keys
  """

  use GenServer

  @type value :: String.t()
  @type id :: pos_integer

  @name __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  @doc """
  Assigns an id to the value and stores the value under that id.
  Returns the id
  """
  @spec put(value) :: {:ok, id}
  def put(value) do
    GenServer.call(@name, {:put, value})
  end

  @doc """
  Retrives the value with the given id
  """
  @spec fetch(id) :: {:ok, value} | :not_found
  def fetch(id) do
    GenServer.call(@name, {:fetch, id})
  end

  def init(:ok) do
    state = %{
      next_id: 1,
      repo: %{}
    }

    {:ok, state}
  end

  def handle_call({:put, value}, _from, %{next_id: next_id, repo: repo} = state) do
    repo = Map.put(repo, next_id, value)
    state = %{state | next_id: next_id + 1, repo: repo}
    {:reply, {:ok, next_id}, state}
  end

  def handle_call({:fetch, id}, _from, %{repo: repo} = state) do
    result =
      case Map.fetch(repo, id) do
        {:ok, value} -> {:ok, value}
        :error -> :not_found
      end

    {:reply, result, state}
  end
end
