defmodule Test do
  def test do
    # seq = [{:match, {:var, :x}, {:atm,:a}},
    #       {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
    #       {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
    #       {:var, :z}]
    # seq = [{:match, {:var, :x}, {:atm,:a}},
    #       {:var, :x}]

    seq = [{:match, {:var, :x}, {:atm, :a}},
            {:match, {:var, :z}, {:atm, :b}},
            {:case, {:var, :x},
              [{:clause, {:atm, :b}, [{:atm, :ops}]},
              {:clause, {:var, :z}, [{:atm, :yes}]}
            ]}
          ]

    # seq = [ {:match, {:var, :x}, {:atm, :a}},
    #         {:match, {:var, :y}, {:atm, :b}},
    #         {:match, {:var, :x}, {:atm, :c}},
    #         {:cons, {:var, :x}, {:var, :y}} ]

    # seq = [{:match, {:var, :x}, {:atm, :a}},
    #         {:match, {:var, :f},
    #         {:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}},
    #         {:apply, {:var, :f}, [{:atm, :b}]} ]

    #Eager.eval_seq(seq, Env.new())
    Eager.eval(seq)
    #Eager.eval_match({:var, :x}, :a, [{:x, :b}])
  end
end
