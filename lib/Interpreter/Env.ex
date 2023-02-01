defmodule Env do
  def test do
    #l = [{:x, :foo}, {:y, :bar}, {:z, :rar}]

    add(:k, :get, [])
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
  def remove(_, nil) do [] end
  def remove(_, []) do [] end
  def remove([], env) do env end
  def remove([id|tail], env) do remove(id, remove(tail, env)) end
  def remove(id, [{id, _}|tail]) do tail end
  def remove(id, [head|tail]) do [head|remove(id, tail)] end

end
