defmodule Shunt do
  def find([], []) do [] end
  def find(xs, [y|ys]) do
    {hs, ts} = Train.split(xs, y)
    tn = length(ts)
    hn = length(hs)
    [{:one, tn+1}, {:two, hn}, {:one, -(tn+1)}, {:two, -hn} | find(Train.append(hs, ts), ys)]
  end

  def few([], _) do [] end
  def few([h | hs], [h | ys]) do few(hs, ys) end
  def few(xs, [y|ys]) do
    {hs, ts} = Train.split(xs, y)
    tn = length(ts)
    hn = length(hs)
    [{:one, tn+1}, {:two, hn}, {:one, -(tn+1)}, {:two, -hn} | few(Train.append(hs, ts), ys)]
  end

  def compress(ms) do
    ns = rules(ms)
    if ns == ms do
      ms
    else
      compress(ns)
    end
  end

  #base case
  def rules([]) do [] end
  # rule 3 and 4
  def rules([{_, 0} | tail]) do rules(tail)end
  # rule 1 and 2
  def rules([{num, n}, {num, m} | tail]) do rules([{num, n+m} | tail]) end
  # If non of the rules apply
  def rules([head | tail]) do [head | rules(tail)] end

end
