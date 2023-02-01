defmodule Test do
  def test do
    seq = [{:match, {:var, :x}, {:atm,:a}},
          {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
          {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
          {:var, :z}]
    Eager.eval(seq)
  end
end
