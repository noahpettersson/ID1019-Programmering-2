defmodule Morse do
  def base() do
    '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... ' end


  def rolled() do
      '.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .---- ' end


  #%%% The decoding tree.

  def decode_table() do
  {:node,:na,
        {:node,116,
              {:node,109,
                    {:node,111,
                          {:node,:na,{:node,48,nil,nil},{:node,57,nil,nil}},
                          {:node,:na,nil,{:node,56,nil,{:node,58,nil,nil}}}},
                    {:node,103,
                          {:node,113,nil,nil},
                          {:node,122,
                                {:node,:na,{:node,44,nil,nil},nil},
                                {:node,55,nil,nil}}}},
              {:node,110,
                    {:node,107,{:node,121,nil,nil},{:node,99,nil,nil}},
                    {:node,100,
                          {:node,120,nil,nil},
                          {:node,98,nil,{:node,54,{:node,45,nil,nil},nil}}}}},
        {:node,101,
              {:node,97,
                    {:node,119,
                          {:node,106,
                                {:node,49,{:node,47,nil,nil},{:node,61,nil,nil}},
                                nil},
                          {:node,112,
                                {:node,:na,{:node,37,nil,nil},{:node,64,nil,nil}},
                                nil}},
                    {:node,114,
                          {:node,:na,nil,{:node,:na,{:node,46,nil,nil},nil}},
                          {:node,108,nil,nil}}},
              {:node,105,
                    {:node,117,
                          {:node,32,
                                {:node,50,nil,nil},
                                {:node,:na,nil,{:node,63,nil,nil}}},
                          {:node,102,nil,nil}},
                    {:node,115,
                          {:node,118,{:node,51,nil,nil},nil},
                          {:node,104,{:node,52,nil,nil},{:node,53,nil,nil}}}}}}
  end


  #%%% The codes in an ordered list.

  def codes do
    [{32, '..--'},
     {37,'.--.--'},
     {44,'--..--'},
     {45,'-....-'},
     {46,'.-.-.-'},
     {47,'.-----'},
     {48,'-----'},
     {49,'.----'},
     {50,'..---'},
     {51,'...--'},
     {52,'....-'},
     {53,'.....'},
     {54,'-....'},
     {55,'--...'},
     {56,'---..'},
     {57,'----.'},
     {58,'---...'},
     {61,'.----.'},
     {63,'..--..'},
     {64,'.--.-.'},
     {97,'.-'},
     {98,'-...'},
     {99,'-.-.'},
     {100,'-..'},
     {101,'.'},
     {102,'..-.'},
     {103,'--.'},
     {104,'....'},
     {105,'..'},
     {106,'.---'},
     {107,'-.-'},
     {108,'.-..'},
     {109,'--'},
     {110,'-.'},
     {111,'---'},
     {112,'.--.'},
     {113,'--.-'},
     {114,'.-.'},
     {115,'...'},
     {116,'-'},
     {117,'..-'},
     {118,'...-'},
     {119,'.--'},
     {120,'-..-'},
     {121,'-.--'},
     {122,'--..'}]
  end

  def encode(text) do
    table = Map.new(codes())
    code(table, text,[])
  end

  def code(_, [], acc) do
    Enum.reverse(acc)
  end

  def code(table, [char | rest], acc) do
    case Map.fetch(table, char) do
        {:ok, signal} -> code(table, rest, [signal | acc])
        :error -> :error
    end
  end

  def encode_table() do
    tup(codes(), 0, {})
  end

  def tup([], _, acc) do acc end
  def tup([{char, mors} | tail], k, acc) do
    if(char == k) do
      tup(tail, k + 1, Tuple.append(acc, mors))
    else
      tup([{char, mors} | tail], k + 1, Tuple.append(acc, :na))
    end
  end

  def decode(text) do
    table = decode_table()
    dec(text, table, [])
  end

  def dec([], _, acc) do
    Enum.reverse(acc)
  end

  def dec(text, table, acc) do
    case getChar(text, table) do
      :na -> IO.puts("na")
      {char, tail} ->
        dec(tail, table, [char | acc])
    end
  end

  def getChar([], {:node, char, _, _}) do {char, []} end
  def getChar([?. | tail], {:node, _, _, dot}) do
    getChar(tail, dot)
  end
  def getChar([?- | tail], {:node, _, dash, _}) do
    getChar(tail, dash)
  end
  def getChar([?\s | _], {:node, :na, _, _}) do :na end
  def getChar([?\s | tail], {:node, char, _, _}) do {char, tail} end


end
