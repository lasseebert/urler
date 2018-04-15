defmodule Urler.EncoderTest do
  use ExUnit.Case

  alias Urler.Encoder

  test "encoding and decoding 0" do
    assert Encoder.encode(0) == "0"
    assert Encoder.decode("0") == {:ok, 0}
  end

  test "encoding and decoding 15" do
    assert Encoder.encode(15) == "f"
    assert Encoder.decode("f") == {:ok, 15}
  end

  test "encoding and decoding 36" do
    assert Encoder.encode(36) == "10"
    assert Encoder.decode("10") == {:ok, 36}
  end

  test "decoding bogus value" do
    assert Encoder.decode("%") == :error
  end
end
