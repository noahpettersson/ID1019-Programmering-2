defmodule Eval do
  @type literal() :: {:num, number()}
  | {:var, atom()}
  | {:q, number(), number()}

  @type expr() :: literal()
    | {:add, expr(), expr()}
    | {:sub, expr(), expr()}
    | {:mul, expr(), expr()}
    | {:div, expr(), expr()}

    # We use Elixirs own Map
    # Create new Map %{}
    # Add keys to map with .put
    # Retrieve keys to map with .get

    def test  do
      env = %{a: 1, b: 2, c: 3, d: 4}
      #expr = {:add, {:add, {:mul, {:num, 2}, {:var, :a}}, {:num, 3}}, {:q, 6, 4}}
      #expr = {:div, {:num, 6}, {:num, 10}}
      #expr = {:div, {:q, 2, 2}, {:q, 2, 4}}
      expr = {:div, {:add, {:add, {:mul, {:num, 2}, {:var, :a}}, {:num, 3}}, {:q, 6, 2}}, {:num, 4}}

      eval(expr, env)
    end

    def eval({:num, n}, _) do n end
    def eval({:var, v}, env) do Map.get(env, v) end
    def eval({:add, e1, e2}, env) do add(eval(e1, env), eval(e2, env)) end
    def eval({:sub, e1, e2}, env) do sub(eval(e1, env), eval(e2, env)) end
    def eval({:mul, e1, e2}, env) do mul(eval(e1, env), eval(e2, env)) end
    def eval({:div, e1, e2}, env) do divi(eval(e1, env), eval(e2, env)) end
    def eval({:q, e1, e2}, _) do quotient(e1, e2) end

    @spec add(number | {:q, number, number}, number | {:q, number, number}) ::
            number | {:q, number, number}
    def add({:q, n, m}, {:q, x, y}) do divi(n*y + x*m, m*y) end
    def add({:q, n, m}, a) do divi(a*m + n, m) end
    def add(a, {:q, n, m}) do divi(a*m + n, m) end
    def add(a, b) do a + b end

    def sub({:q, n, m}, {:q, x, y}) do divi(n*y - x*m, m*y) end
    def sub({:q, n, m}, a) do divi(a*m - n, m) end
    def sub(a, {:q, n, m}) do divi(a*m - n, m) end
    def sub(a, b) do a - b end

    def mul({:q, n, m}, {:q, x, y}) do divi(n*x, m*y) end
    def mul({:q, n, m}, a) do divi(n*a, m) end
    def mul(a, {:q, n, m}) do divi(n*a, m) end
    def mul(a, b) do a * b end

    def divi({:q, n, m}, {:q, x, y}) do divi(n*y, m*x) end
    def divi({:q, n, m}, a) do divi(n, m*a) end
    def divi(a, {:q, n, m}) do divi(n, m*a) end
    def divi(a, b) do
      if(rem(a, b) == 0) do
        trunc(a / b)
      else
        x = gcd(a, b)
        if(x == 1) do
          {:q, a, b}
        else
          divi(trunc((a/x)),trunc((b/x)))
        end
      end
    end

    def quotient(e1, e2) do
      {:q, trunc(e1/gcd(e1,e2)), trunc(e2/gcd(e1,e2))}
    end

    def gcd(x, 0) do x end
    def gcd(x, y) do gcd(y, rem(x,y)) end
end
