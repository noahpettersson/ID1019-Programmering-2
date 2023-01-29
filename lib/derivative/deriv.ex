defmodule Deriv do
 @type literal() :: {:num, number()} | {:var, atom()}

 @type expr() :: literal()
 | {:add, expr(), expr()}
 | {:mul, expr(), expr()}
 | {:exp, expr(), literal()}
 | {:ln, literal()}
 | {:sqrt, expr()}
 | {:frac, expr(), expr()}
 | {:sin, expr()}


def test do
  e = {:sqrt, {:mul, {:num, 2}, {:var, :x}}}
  d = deriv(e, :x)
  simplify(d)
  # IO.write("expression #{pprint(e)}\n")
  # IO.write("derivative #{pprint(d)}\n")
  # IO.write("simplified #{pprint(simplify(d))}\n")
end

def test2 do
  e =  {:add,
        {:mul, {:num, 5}, {:var, :x}},
        {:exp, {:var, :x}, {:num, 3}}
        }
  d = deriv(e, :x)
  IO.write("expression #{pprint(e)}\n")
  IO.write("derivative #{pprint(d)}\n")
  IO.write("simplified #{pprint(simplify(d))}\n")
  #simplify_frac({:var, :x},{:var, :x})
end

def testln do
  e = {:add,
        {:exp, {:var, :x}, {:num, 5}},
        {:exp, {:var, :x}, {:num, 2}} }

  d = deriv(e, :x)
  IO.write("expression #{pprint(e)}\n")
  IO.write("derivative #{pprint(d)}\n")
  IO.write("simplified #{pprint(simplify(d))}\n")
end

def test3 do
  e = {:frac, {:mul, {:num, 2}, {:var, :x}}, {:exp, {:var, :x}, {:num, 2}}}
  simplify(e)
  #d = deriv(e, :x)
  #IO.write("expression #{pprint(e)}\n")
  #IO.write("derivative #{pprint(d)}\n")
  #IO.write("simplified #{pprint(simplify(d))}\n")
end

 def deriv({:exp, e ,{:num, n}}, v) do
  {:mul,
    {:mul, {:num, n}, {:exp, e, {:num, n-1}}},
    deriv(e, v) }
 end

 def deriv({:num, _}, _) do {:num, 0} end
 def deriv({:var, v}, v) do {:num, 1} end
 def deriv({:var, _}, _) do {:num, 0} end
 def deriv({:add, e1, e2}, v) do
  {:add, deriv(e1, v), deriv(e2, v)}
 end
 def deriv({:mul, e1, e2}, v) do
  {:add,
    {:mul, deriv(e1, v), e2},
    {:mul, e1, deriv(e2, v)} }
 end
 def deriv({:ln, {:num, _}}, _) do 0 end
 def deriv({:ln, {:var, v}}, v) do {:frac, {:num, 1}, {:var, v}} end
 #def derv({:ln, e}, v) do {:frac, {deriv(e, v)}, e} end
 def deriv({:frac, {:num, n}, {:var, v}}, v) do {:frac, {:num, -1 * n}, {:exp, {:var, v}, {:num, 2}}} end
 def deriv({:sqrt, e}, v) do {:frac, deriv(e, v), {:mul, {:num, 2}, {:sqrt, e}}} end
 def deriv({:sin, {:var, v}}, v) do {:cos, {:var, v}} end
 def deriv({:cos, {:var, v}}, v) do {:mul, {:num, -1}, {:sin, {:var, v}}} end

 def simplify({:add, e1, e2}) do
  simplify_add(simplify(e1), simplify(e2))
 end

 def simplify({:mul, e1, e2}) do
  simplify_mul(simplify(e1), simplify(e2))
 end

 def simplify({:exp, e1, e2}) do
  simplify_exp(simplify(e1), simplify(e2))
 end

 def simplify({:frac, e1, e2}) do
  simplify_frac(simplify(e1), simplify(e2))
  simplify_frac(simplify(e1), simplify(e2))
 end

 def simplify({:sqrt, e}) do simplify_sqrt(simplify(e)) end

 def simplify(e) do e end

 def simplify_add({:num, 0}, e2) do e2 end
 def simplify_add(e1, {:num, 0}) do e1 end
 def simplify_add({:num, n1}, {:num, n2}) do {:num, n1 + n2} end
 def simplify_add(e1, e2) do {:add, e1, e2} end

 def simplify_frac({:num, 0}, _) do {:num, 0} end
 def simplify_frac(_, {:num, 0}) do {:num, 0} end
 def simplify_frac(e1, {:num, 1}) do e1 end
 def simplify_frac({:mul, {:num, n}, {:var, v}}, {:mul, {:num, n}, e}) do {:frac, {:var, v}, e} end
 def simplify_frac({:var, v}, {:var, v}) do {:num, 1} end
 def simplify_frac({:num, n}, {:num, n}) do {:num, 1} end

 # {:frac, {:mul, {:num, 2}, {:var, :x}}, {:exp, {:var, :x}, {:num, 2}}}
 def simplify_frac({:mul, {:num, n1}, {:var, v}}, {:exp, {:var, v}, {:num, n2}}) do {:frac, {:num, n1}, {:exp, {:var ,v}, {:num, n2 - 1}}} end

 def simplify_sqrt({:exp, {:var, v}, {:num, 2}}) do {:var, v} end


 def simplify_mul({:num, 0}, _) do {:num, 0} end
 def simplify_mul(_, {:num, 0}) do {:num, 0} end
 def simplify_mul({:num, 1}, e2) do e2 end
 def simplify_mul(e1, {:num, 1}) do e1 end
 def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1 * n2} end





#  def simplify_mul({:frac, {:num, _}, {:var, v}}, {:var, v}) do {:num, 1} end
#  def simplify_mul({:frac, {:num, n1}, {:var, v}}, {:num, n2}) do {:frac, n1 * n2, v} end
#  def simplify_mul({:frac, {:num, n1}, {:var, _}}, {:mul, {:num, n2}, {:var, _}}) do {:num, n1 * n2} end
#  def simplify_mul({:frac, {:num, n1}, {:var, _}}, {:mul, {:var, _}, {:num, n2}}) do {:num, n1 * n2} end
#  def simplify_mul({:frac, {:num, n1}, {:var, v}}, {:exp, {:var, v}, {:num, n2}}) do {:exp, v, {:num, n2 - n1}} end
#  def simplify_mul({:var, v}, {:frac, {:num, _}, {:var, v}}) do {:num, 1} end
#  def simplify_mul({:num, n2}, {:frac, {:num, n1}, {:var, v}}) do {:frac, n1 * n2, v} end
#  def simplify_mul({:mul, {:num, n2}, {:var, _}}, {:frac, {:num, n1}, {:var, _}}) do {:num, n1 * n2} end
#  def simplify_mul({:mul, {:var, _}, {:num, n2}}, {:frac, {:num, n1}, {:var, _}}) do {:num, n1 * n2} end
#  def simplify_mul({:exp, {:var, v}, {:num, n2}}, {:frac, {:num, n1}, {:var, v}}) do {:exp, v, {:num, n2 - n1}} end

 def simplify_mul(e1, e2) do {:mul, e1, e2} end

 def simplify_exp(_, {:num, 0}) do {:num, 1} end
 def simplify_exp(e1, {:num, 1}) do e1 end
 def simplify_exp({:num, n1}, {:num, n2}) do :math.pow(n1, n2) end
 def simplify_exp(e1, e2) do {:exp, e1, e2} end

 def pprint({:num, n}) do "#{n}" end
 def pprint({:var, v}) do "#{v}" end
 def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
 def pprint({:mul, e1, e2}) do "#{pprint(e1)} * #{pprint(e2)}" end
 def pprint({:exp, e1, e2}) do "#{pprint(e1)}^#{pprint(e2)}" end
 def pprint({:ln, e}) do "ln(#{pprint(e)})" end
 def pprint({:frac, e1, e2}) do "#{pprint(e1)}/(#{pprint(e2)})" end
 def pprint({:sqrt, e}) do "sqrt(#{pprint(e)})" end
 def pprint({:sin, e}) do "sin(#{pprint(e)})" end
 def pprint({:cos, e}) do "cos(#{pprint(e)})" end

end
