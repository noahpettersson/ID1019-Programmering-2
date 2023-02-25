defmodule Bench do

  def bench() do bench(100) end

  def bench(i, n) do

    {add, _} = :timer.tc(fn() -> Dinner.start(n) end)

    {i, add}
    end

    def bench(n) do
      ls = [1,2,3,4,5,6,7,8,9,10]

      :io.format("# benchmark with ~w operations, time per operation in us\n", [n])
      :io.format("~6.s~12.s\n", ["n", "add"])

      Enum.each(ls, fn (i) ->
          {i, tla} = bench(i, n)
          :io.format("~6.w~12.2f\n", [i, tla/n])
        end)
      end


  ###########################################################################################
  # Bench tree

  # def bench() do bench(100) end

  # def bench(i, n) do
  #   seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)

  #   list = Enum.reduce(seq, EnvTree.new(), fn(e, list) ->
  #                       EnvTree.add(list, e, :foo)
  #                       end)

  #   seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)

  #   {add, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         EnvTree.add(list, e, :foo) end) end)

  #   {lookup, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         EnvTree.lookup(list, e) end) end)

  #   {remove, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         EnvTree.remove(list, e) end) end)

  #   {i, add, lookup, remove}
  #   end

  #   def bench(n) do
  #     ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

  #     :io.format("# benchmark with ~w operations, time per operation in us\n", [n])
  #     :io.format("~6.s~12.s~12.s~12.s\n", ["n", "add", "lookup", "remove"])

  #     Enum.each(ls, fn (i) ->
  #         {i, tla, tll, tlr} = bench(i, n)
  #         :io.format("~6.w~12.2f~12.2f~12.2f\n", [i, tla/n, tll/n, tlr/n])
  #       end)
  #     end

  ###########################################################################################
  # Bench list
  # def bench() do bench(100) end

  # def bench(i, n) do
  #   seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)

  #   list = Enum.reduce(seq, EnvList.new(), fn(e, list) ->
  #                       EnvList.add(list, e, :foo)
  #                       end)

  #   seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)

  #   {add, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         EnvList.add(list, e, :foo) end) end)

  #   {lookup, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         EnvList.lookup(list, e) end) end)

  #   {remove, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         EnvList.remove(list, e) end) end)

  #   {i, add, lookup, remove}
  #   end

  #   def bench(n) do
  #     ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

  #     :io.format("# benchmark with ~w operations, time per operation in us\n", [n])
  #     :io.format("~6.s~12.s~12.s~12.s\n", ["n", "add", "lookup", "remove"])

  #     Enum.each(ls, fn (i) ->
  #         {i, tla, tll, tlr} = bench(i, n)
  #         :io.format("~6.w~12.2f~12.2f~12.2f\n", [i, tla/n, tll/n, tlr/n])
  #       end)
  #     end

  ###########################################################################################
  # Bench elixir map
  # def bench() do bench(100) end

  # def bench(i, n) do
  #   seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)

  #   list = Enum.reduce(seq, Map.new(), fn(e, list) ->
  #                       Map.put(list, e, :foo)
  #                       end)

  #   seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)

  #   {put, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         Map.put(list, e, :foo) end) end)

  #   {get, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         Map.get(list, e) end) end)

  #   {delete, _} = :timer.tc(fn() ->
  #                     Enum.each(seq, fn(e) ->
  #                         Map.delete(list, e) end) end)

  #   {i, put, get, delete}
  #   end

  #   def bench(n) do
  #     ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

  #     :io.format("# benchmark with ~w operations, time per operation in us\n", [n])
  #     :io.format("~6.s~12.s~12.s~12.s\n", ["n", "put", "get", "delete"])

  #     Enum.each(ls, fn (i) ->
  #         {i, tla, tll, tlr} = bench(i, n)
  #         :io.format("~6.w~12.2f~12.2f~12.2f\n", [i, tla/n, tll/n, tlr/n])
  #       end)
  #     end
end
