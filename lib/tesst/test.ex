defmodule Test do
  def test do

    # g = fn(x) -> x + 5 end
    # h = fn(x) -> if x == :dog do :fido; else x end end
    # t = fn(x) -> 2*x + 5 end
    # p = fn(x, y) -> x * y end
    # s = fn(x, y) -> x + y end
    #k = fn(x) -> rem(x,2) == 1 end
    #k = fn(x) -> x>5 end

    #l = [1,2,3,4,5,6,7,8,9]
    #l2 = [:cat, :mouse, :dog, :horse]


    f = fn(x) -> x * 2 end
    Higher.apply_to_all([1,2,3,4], f)


    # Hof.apply_to_all([1,2,3,4], g)
    # Hof.apply_to_all([:dog, :cat, :cow, :horse], h)
    # Hof.apply_to_all([1,2,3,4], t)
    # Hof.prod(l)
    #Hof.odd(l)
    #Higher.filter(l, k)
    #Higher.double_five_animal(l, :double)
    #Hof.fold_right(l, 0, fn(x, y) -> x * y end)
    #fold_left([1,2,3,4], 1, fn(x, y) -> x * y end)

  end
end
