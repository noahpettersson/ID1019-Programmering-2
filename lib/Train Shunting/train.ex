defmodule Train do
  def take(_, 0) do [] end
  def take([head | tail], n) do
    [head | take(tail, n-1)]
  end

  def drop(train, 0) do train end
  def drop([_ | tail], n) do
    drop(tail, n-1)
  end

  def append([], train2) do
    train2
  end
  def append([h1 | t1],train2) do
    [h1 | append(t1, train2)]
  end

  def member([], _) do false end
  def member([head | tail], y) do
    if(head == y) do
      true
    else
      member(tail, y)
    end
  end

  def position(train, y) do
    position(train, y, 1)
  end
  def position([head | tail], y, a) do
    if(head == y) do
      a
    else
      position(tail, y, a+1)
    end
  end

  def split([y | tail], y) do {[], tail} end
  def split([head | tail], y) do
    {tail, rest} = split(tail, y)
    {[head | tail], rest}
  end

  def main([], n) do {n, [], []} end
  def main([h|t], n) do
    case main(t, n) do
      {0, drop, take} -> {0, [h|drop], take}
      {n, drop, take} -> {n-1, drop, [h|take]}
    end
  end

end
