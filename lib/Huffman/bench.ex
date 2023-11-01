defmodule HuffBench do

  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def freq do
    text = Huffman.text()
    freq = Huffman.freq(text)
    tree = Huffman.huffman(freq)
    table = Huffman.encode_table(tree)
    IO.inspect(table, label: "table")
    encode = Huffman.encode(sample(), table)
    Huffman.decode(encode, table)
  end

  def text do

    text = Huffman.read('lib/Huffman/bookem210k.txt')
    #Text size: 20423
    text1 = Huffman.read('lib/Huffman/100west.txt')

    # Text size: 40257
    text2 = Huffman.read('lib/Huffman/5orange.txt')

    # Text size: 50520
    text3 = Huffman.read('lib/Huffman/aquith.txt')

    text4 = Huffman.read('lib/Huffman/batlslau100k.txt')

    #text4 = Huffman.read('lib/Huffman/bureau150.txt')

    text5 = Huffman.read('lib/Huffman/robotech200k.txt')

    # Text size: 318997
    text6 = Huffman.read('lib/Huffman/kallocain.txt')

    [text, text1, text2, text3, text4, text5, text6]
  end

  def testEncode do
    testEncode(text())
  end

  def bench do
    testEncode()
    IO.puts("----------------------\n")
    testDecode()
  end

  def testEncode([]) do [] end
  def testEncode([text | tail]) do
    length = length(text)

    x = Huffman.tree(text)
    table = Huffman.encode_table(x)

    {encode, _} = :timer.tc(fn() ->
          Huffman.encode(text, table)
        end)

    seq = Huffman.encode(text, table)

    Huffman.decode(seq, table)
    #:io.format("# Length of text ~w: Decode time: ~6w\n", [length, decode])
    :io.format("# Length of text ~w: \n", [length])
    :io.format("# Encode time: ~6.2f ms\n\n", [encode/1000])

    testEncode(tail)
  end

  def testDecode do
    testDecode(text())
  end

  def testDecode([]) do [] end
  def testDecode([text | tail]) do
    length = length(text)

    x = Huffman.tree(text)
    table = Huffman.encode_table(x)

    seq = Huffman.encode(text, table)

    {decode, _} = :timer.tc(fn() ->
          Huffman.decode(seq, table)
        end)
    #:io.format("# Length of text ~w: Decode time: ~6w\n", [length, decode])
    :io.format("# Length of text ~w: \n", [length])
    :io.format("# Decode time: ~6.2f ms\n\n", [decode/1000])

    testDecode(tail)
  end
end
