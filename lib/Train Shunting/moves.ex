defmodule Moves do

  # move - {:one,1}
  # state - {[:a,:b],[],[]}
  # result - {[:a],[:b],[]}
  def single(move, {main, one, two}) do
    case move do
      {:one, n1} ->
        if(n1 == 0) do {main, one, two} end
        if(n1 > 0) do
          {_, remain, take} = Train.main(main, n1)
          {remain, Train.append(take, one), two}
        else
          {Train.append(main, Train.take(one, n1*-1)), Train.drop(one, n1*-1), two}
        end

      {:two, n2} ->
        if(n2 == 0) do {main, one, two} end
        if(n2 > 0) do
          {_, remain, take} = Train.main(main, n2)
          {remain, one, Train.append(take, two)}
        else
          {Train.append(main, Train.take(two, n2*-1)), one, Train.drop(two, n2*-1)}
        end
    end
  end

  def sequence([], state) do [state] end
  def sequence([head | tail], state) do
    [state | sequence(tail, single(head, state))]
  end
end
