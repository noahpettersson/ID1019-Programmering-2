defmodule Env do
  def test do
    #l = [{:x, :foo}, {:y, :bar}, {:z, :rar}]
    l = [{:x, :foo}, {:x, :bar}]

    remove([:x], l)
  end

  def new do [] end

  # def add(id, str, env) do end
  def add(id, str, []) do [{id, str}] end
  def add(id, str, [{id, _} | tail]) do [{id, str} | tail] end
  def add(id, str, [head | tail]) do [head | add(id, str, tail)] end

  # def lookup(id, env)
  def lookup(_, []) do nil end
  def lookup(id, [{id, str} | _]) do {id, str} end
  def lookup(id, [ _ | tail]) do lookup(id, tail) end

  # def remove(ids, env)
  # def remove(_, nil) do [] end
  # def remove(_, []) do [] end
  # def remove([], env) do env end
  # def remove([id|tail], env) do remove(id, remove(tail, env)) end
  # def remove(id, [{id, _}|tail]) do tail end
  # def remove(id, [head|tail]) do [head|remove(id, tail)] end
  def remove(keys, env) do
    List.foldr(keys, env, fn(key, env) ->
      List.keydelete(env, key, 0)
    end)
  end

  def closure(keyss, env) do
    List.foldr(keyss, [], fn(key, acc) ->
      case acc do
        :error -> :error

        cls ->
          case lookup(key, env) do
            {key, value} ->
              [{key, value} | cls]

            nil ->
              :error
          end
      end
    end)
  end

  def args(pars, args, env) do
    List.zip([pars, args]) ++ env
  end

end
