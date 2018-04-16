defmodule UrlerTest do
  use ExUnit.Case

  alias Urler.Store

  test "shorten a URL and look it up again" do
    Store.start_link()
    url = "https://example.com/foo"

    {:ok, short_url} = Urler.shorten(url)
    {:ok, resolved_url} = Urler.resolve(short_url)

    assert resolved_url == url
    assert short_url =~ ~r{^/[a-z0-9]+$}
  end

  test "looking up short_url without correct prefix" do
    assert Urler.resolve("abcd") == :invalid
  end

  test "looking up short_url with bogus short_string" do
    assert Urler.resolve("/%%") == :invalid
  end
end
