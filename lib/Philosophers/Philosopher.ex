defmodule Philosopher do

  @dream 800
  @eat 100
  @timeout 1000

  def start(hunger, strength, right, left, name, ctrl, x) do
    spawn_link(fn -> init(hunger, strength, right, left, name, ctrl, x) end)
  end


  def init(hunger, strength, right, left, name, ctrl, x) do
    gui = Gui.start(name)
    dreaming(hunger, strength, right, left, name, ctrl, gui, x)
  end

  defp dreaming(0, _strength, _right, _left, name, ctrl, gui, _x) do
    IO.puts("#{name} is done")
    send(gui, :stop)
    send(ctrl, :done)
  end
  defp dreaming(hunger, 0, _left, _right, name, ctrl, gui, _) do
    IO.puts("#{name} is starved to death, hunger is down to #{hunger}!")
    send(gui, :stop)
    send(ctrl, :done)
  end
  defp dreaming(hunger, strength, right, left, name, ctrl, gui, x) do
    IO.puts("#{name} is dreaming their hunger is #{hunger}")

    send(gui, :leave)

    sleep(@dream)

    IO.puts("#{name} woke up")
    waitingChop(hunger, strength, right, left, name, ctrl, gui, x)
  end

  defp waitingChop(hunger, strength, right, left, name, ctrl, gui, x) do
    send(gui, :waiting)
    IO.puts("#{name} is waiting for chopsticks")
    ref = make_ref()

    sleep(x)
    IO.inspect(x, label: "x")
    Chopstick.async(right, ref)
    Chopstick.async(left, ref)

    case Chopstick.synch(ref, @timeout) do
      :ok ->
        IO.puts("#{name} recieved the right chopstick")
        #sleep(@timeout)
        case Chopstick.synch(ref, @timeout) do
          :ok ->
            sleep(100)
            IO.puts("#{name} has recieved both chopsticks")
            eating(hunger, strength, right, left, name, ctrl, ref, gui, x)
          :no ->
            Chopstick.return(right, ref)
            Chopstick.return(left, ref)
            IO.inspect("inside no")
            dreaming(hunger, strength - 1, right, left, name, ctrl, gui, x+300)
        end
      :no ->
        Chopstick.return(right, ref)
        Chopstick.return(left, ref)
        IO.inspect("ouside no")
        dreaming(hunger, strength - 1, right, left, name, ctrl, gui, x+300)
    end
  end

  #####################################################################################

  # defp waitingChop(hunger, right, left, name, ctrl, gui) do
  #   send(gui, :waiting)
  #   IO.puts("#{name} is waiting for both chopsticks")
  #   x = Chopstick.request_both(right, left, 500)
  #   IO.inspect(x, label: "x")
  #   case x do
  #     :ok ->
  #       IO.puts("#{name} has recieved both chopsticks")
  #       eating(hunger, right, left, name, ctrl, gui)
  #     :no -> dreaming(hunger, right, left, name, ctrl, gui)
  #   end
  # end


  # case Chopstick.request(left) do
  #   :ok ->
  #     IO.puts("#{name} recieved the right chopstick")
  #     case Chopstick.request(right) do
  #       :ok ->
  #         IO.puts("#{name} has recieved both chopsticks")
  #         eating(hunger, right, left, name, ctrl, ref, gui)
  #       :no ->
  #         Chopstick.return(left)
  #         dreaming(hunger, right, left, name, ctrl, gui)
  #     end
  #   :no ->
  #     #Chopstick.return(right, ref)
  #     #Chopstick.return(left, ref)
  #     dreaming(hunger, right, left, name, ctrl, gui)
  # end

  #####################################################################################

  defp eating(hunger, strength, right, left, name, ctrl, ref, gui, x) do
    send(gui, :enter)
    IO.puts("#{name} is eating")
    sleep(@eat)
    IO.puts("#{name} has finished eating")

    Chopstick.return(right, ref)
    IO.puts("#{name} has left the right chopstick")

    Chopstick.return(left, ref)
    IO.puts("#{name} has left the left chopstick")

    dreaming(hunger - 1, strength, right, left, name, ctrl, gui, x)
  end

  def sleep(0) do :ok end
  def sleep(t) do
    x = :rand.uniform(t)
    IO.inspect(x, label: "======================== x")
    :timer.sleep(x)
  end

end
