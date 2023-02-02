defmodule Eager do
  def eval(seq) do
    IO.inspect(seq)
    eval_seq(seq, Env.new())
  end

  def eval_expr({:atm, id}, _) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil -> :error
      {_, str} -> {:ok, str}
    end
  end
  def eval_expr({:cons, head, tail}, env) do
    case eval_expr(head, env) do
      :error -> :error
      {:ok, str} ->
        case eval_expr(tail, env) do
          :error -> :error
          {:ok, ts} -> {:ok, {str, ts}}
        end
    end
  end
  def eval_expr({:case, expr, cls}, env) do
    case eval_expr(expr, env) do
      :error -> :error
      {:ok, str} -> eval_cls(cls, str, env)
    end
  end
  def eval_expr({:lambda, par, free, seq}, env) do
    case Env.closure(free, env) do
      :error -> :error
      closure -> {:ok, {:closure, par, seq, closure}}
    end
  end
  def eval_expr({:apply, expr, args}, env) do
    case eval_expr(expr, env) do
      :error -> :error
      {:ok, {:closure, par, seq, closure}} ->
        case eval_args(args, env) do
          :error -> :error
          {:ok, strs} ->
            env = Env.args(par, strs, closure)
            eval_seq(seq, env)
          end
        end
  end

  def eval_args(args, env) do
    eval_args(args, env, [])
  end

  def eval_args([], _, strs) do {:ok, Enum.reverse(strs)}  end
  def eval_args([expr | exprs], env, strs) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, str} ->
        eval_args(exprs, env, [str|strs])
    end
  end

  def eval_cls([], _, _) do :error end
  def eval_cls([{:clause, ptr, seq} | cls], str, env) do
    case eval_match(ptr, str, eval_scope(ptr, env)) do
      :fail -> eval_cls(cls, str, env)
      {:ok, env} -> eval_seq(seq, env)
    end
  end

  def eval_match(:ignore, _, env) do {:ok, env} end
  def eval_match({:atm, id}, id, env) do {:ok, env} end
  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil -> {:ok, Env.add(id, str, env)}
      {_, ^str} -> {:ok, env}
      {_, _} -> :fail
    end
  end
  def eval_match({:cons, hp, tp}, {hs, ts}, env) do
    case eval_match(hp, hs, env) do
      :fail -> :fail
      {:ok, env} -> eval_match(tp, ts, env)
    end
  end
  def eval_match(_, _, _) do :fail end

  def eval_scope(ptr, env) do
    Env.remove(extract_vars(ptr), env)
  end

  def eval_seq([exp], env) do
    IO.inspect(exp)
    eval_expr(exp, env)
  end
  def eval_seq([{:match, ptr, exp} | seq], env) do
    case eval_expr(exp, env) do
      :error -> :error
      {:ok, str} ->
        env = eval_scope(ptr, env)
        IO.inspect(env)
        case eval_match(ptr, str, env) do
          :fail -> :error
          {:ok, env} -> eval_seq(seq, env)
        end
    end
  end

  def extract_vars(pattern) do
    extract_vars(pattern, [])
  end
  def extract_vars({:atm, _}, vars) do vars end
  def extract_vars(:ignore, vars) do vars end
  def extract_vars({:var, var}, vars) do
    [var | vars]
  end
  def extract_vars({:cons, head, tail}, vars) do
    extract_vars(head, extract_vars(tail, vars))
  end

end
