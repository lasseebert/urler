defmodule Urler.Encoder do
  @moduledoc """
  Encodes and decodes integers into short strings
  """

  @alphabet ~w(0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z)
  @radix length(@alphabet)
  @num_to_letter @alphabet
                 |> Enum.with_index()
                 |> Enum.map(fn {l, n} -> {n, l} end)
                 |> Enum.into(%{})
  @letter_to_num @alphabet |> Enum.with_index() |> Enum.into(%{})

  @doc """
  Encodes an integer to a short string
  """
  @spec encode(non_neg_integer) :: String.t()
  def encode(num) when num >= 0 do
    encode(num, "")
  end

  @doc """
  Decodes a string back to the integer
  """
  @spec decode(String.t()) :: {:ok, non_neg_integer} | :error
  def decode(word) do
    word
    |> String.graphemes()
    |> Enum.reverse()
    |> decode(1, 0)
  end

  defp encode(0, ""), do: Map.fetch!(@num_to_letter, 0)
  defp encode(0, acc), do: acc

  defp encode(num, acc) do
    remainder = rem(num, @radix)
    rest = div(num, @radix)

    letter = Map.fetch!(@num_to_letter, remainder)

    encode(rest, letter <> acc)
  end

  defp decode([], _multiplier, acc), do: {:ok, acc}

  defp decode([letter | rest], multiplier, acc) do
    case Map.fetch(@letter_to_num, letter) do
      {:ok, value} ->
        decode(rest, multiplier * @radix, acc + value * multiplier)

      :error ->
        :error
    end
  end
end
