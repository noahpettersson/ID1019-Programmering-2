defmodule Hanoi do

  def test do
    hanoi(10, :a, :b, :c)
  end

  def hanoi(0, _, _, _) do [] end

  def hanoi(n, from, aux, to) do
    hanoi(n-1, from, to, aux) ++
    [{:move, from, to}] ++
    hanoi(n-1, aux, from, to)
  end
end
