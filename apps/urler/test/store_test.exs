defmodule Urler.StoreTest do
  use ExUnit.Case

  alias Urler.Store

  test "put and fetch" do
    Store.start_link()

    value = "foo"
    {:ok, id} = Store.put(value)
    {:ok, restored} = Store.fetch(id)

    assert restored == value
    assert is_integer(id)
  end

  test "fetch unknown short_url" do
    Store.start_link()
    assert Store.fetch("bogus") == :not_found
  end
end
