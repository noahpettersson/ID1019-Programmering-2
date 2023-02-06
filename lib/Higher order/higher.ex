defmodule Higher do
  def double([]) do [] end
  def double([head | tail]) do
    [head*2 | double(tail)]
  end

  def five([]) do [] end
  def five([head | tail]) do
    [head+5 | five(tail)]
  end

  def animal([]) do [] end
  def animal([head | tail]) do
    if head == :dog do
      [:fido | animal(tail)]
    else
      [head | animal(tail)]
    end
  end

  def double_five_animal([], _f) do [] end
  def double_five_animal([head | tail], f) do
    case f do
      :double -> [head*2 | double(tail)]
      :five -> [head+5 | five(tail)]
      :animal ->
        if head == :dog do
          [:fido | animal(tail)]
        else
          [head | animal(tail)]
        end
    end
  end

  # f = fn(x) -> x * 2 end
  # g = fn(x) -> x + 5 end
  # h = fn(x) -> if x == :dog do :fido; else x end end

  def apply_to_all([], _) do [] end
  def apply_to_all([head | tail], f) do
    [f.(head) | apply_to_all(tail, f)]
  end

  def sum([]) do 0 end
  def sum( [head | tail] ) do
    head + sum(tail)
  end

  def prod([]) do 1 end
  def prod([head | tail]) do
    head * prod(tail)
  end

  def fold_right([], base, _ ) do base end
  def fold_right([head | tail], base, f ) do
    f.(head, fold_right(tail, base, f))
  end

  def fold_left([], acc, _) do acc end
  def fold_left([head|tail], acc, op) do
    fold_left(tail, op.(head, acc), op)
  end

  def odd( [] ) do [] end
  def odd([head | tail]) do
    if rem(head,2) == 1 do
      [head | odd(tail)]
    else
      odd(tail)
    end
  end

  def filter([], _) do [] end
  def filter([head | tail], f) do
    if f.(head) do
      [head | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

  # def foldr([], acc, op) do acc end
  # def foldr([h | t], acc, op) do
  #   op.(h, foldr(t, acc, op))
  # end

  # def sum(1) do
  #   add = ...
  #   foldr(1, ..., add)
  # end
end
