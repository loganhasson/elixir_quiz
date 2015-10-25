defmodule RunLengthEncoding do
  @moduledoc """
  Apply run-length encoding to a given string.
  """

  @doc """
  Encodes a passed-in string.

  ## Examples

      iex> RunLengthEncoding.encode("hello")
      "1h1e2l1o"

      iex> RunLengthEncoding.encode("JJJTTWPPMMMMX")
      "3J2T1W2P4M1X"

      iex> RunLengthEncoding.encode("ABC")
      "1A1B1C"
  """
  def encode(string) do
    string
    |> chunk
    |> Stream.map(&compress/1)
    |> Enum.join
  end

  @doc """
  Same as .encode. Just does it in parallel.

  ## Examples

      iex> RunLengthEncoding.encode("hello")
      "1h1e2l1o"

      iex> RunLengthEncoding.encode("JJJTTWPPMMMMX")
      "3J2T1W2P4M1X"

      iex> RunLengthEncoding.encode("ABC")
      "1A1B1C"
  """
  def pencode(string) do
    string
    |> chunk
    |> Enum.map(&parallel_compress(&1, self))
    |> Enum.map(&await_compression/1)
    |> Enum.join
  end

  @doc """
  Returns a binary representing a compressed char list.

  ## Examples

      iex> RunLengthEncoding.compress('cc')
      "2c"

      iex> RunLengthEncoding.compress('a')
      "1a"

  """
  def compress(char_list) do
    [length(char_list), <<List.first(char_list)>>]
    |> Enum.join
  end

  @doc """
  Returns a Stream that will, when run, return a string into a chunked list of
  char lists.

  ## Examples

      iex> RunLengthEncoding.chunk("hello") |> Enum.into([])
      ['h', 'e', 'll', 'o']
  """
  def chunk(string) do
    string |> String.to_char_list |> Stream.chunk_by(&(&1))
  end

  defp parallel_compress(char_list, parent) do
    spawn_link fn ->
      send parent, {self, compress(char_list)}
    end
  end

  defp await_compression(pid) do
    receive do
      {^pid, result} -> result
    end
  end
end
