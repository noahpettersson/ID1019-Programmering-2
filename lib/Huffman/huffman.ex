defmodule Huffman do
  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
  'this is something that we should encode'
  end

  def read(file) do
    {:ok, file} = File.open(file, [:read, :utf8])
    binary = IO.read(file, :all)
    File.close(file)
    case :unicode.characters_to_list(binary, :utf8) do
      {:incomplete, list, _} -> list
      list -> list
    end
  end

  def tree(sample) do
    freq = freq(sample)
    huffman(freq)
  end

  # def freq(sample) do
  #   freq(sample, Map.new)
  # end
  # def freq([], freq) do
  #   freq
  # end
  # def freq([char | rest], freq) do
  #   freq =
  #     case Map.get(freq, char) do
  #       nil -> Map.put(freq, char, 1)
  #       count -> Map.put(freq, char, count + 1)
  #     end
  #   freq(rest, freq)
  # end

  def freq(sample) do
    IO.inspect(sample)
    freq(sample, [])
  end
  def freq([], freq), do: freq
  def freq([char | rest], freq) do
    IO.inspect(char, label: "-----------------------")
    case Enum.find(freq, fn {c, _} -> c == char end) do
      nil ->
        freq(rest, [{char, 1} | freq])
      {char, n} ->
        freq(rest, [{char, n + 1} | List.delete(freq, {char, n})])
    end
  end

  def huffman(freq) do
    sorted = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
    huffman_tree(sorted)
  end

  def huffman_tree([{tree, _}]), do: tree
  def huffman_tree([{a, af}, {b, bf} | rest]) do
    huffman_tree(insert({{a, b}, af + bf}, rest))
  end

  def insert({a, af}, []), do: [{a, af}]
  def insert({a, af}, [{b, bf} | rest]) when af < bf do
    [{a, af}, {b, bf} | rest]
  end
  def insert({a, af}, [{b, bf} | rest]) do
    [{b, bf} | insert({a, af}, rest)]
  end

  def encode_table(tree) do
    codes(tree, [])
  end

  def codes({a, b}, sofar) do
    as = codes(a, [0 | sofar])
    bs = codes(b, [1 | sofar])
    as ++ bs
  end
  def codes( a, code) do
    [{a, Enum.reverse(code)}]
  end

  def encode([], _) do [] end
  def encode([char | rest], table) do
    {_, code} = List.keyfind(table, char, 0)
    code ++ encode(rest, table)
  end

  def decode([], _) do
    []
  end

  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest};
      nil ->
        decode_char(seq, n + 1, table)
    end
  end
end
