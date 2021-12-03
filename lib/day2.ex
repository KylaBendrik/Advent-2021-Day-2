defmodule Day2 do
  @moduledoc """
  forward x increases the horizontal position by x
  down x increases the depth by x
  up x decreases the depth by x
  
  """

  
  def run(filename, :stage1) do
    # initialize position map: {h: int, d: int}
    pos = initialize_position()
    # run input_text through translator
    moves = translate(filename)
    # apply positional changes
    new_pos = move(pos, moves)
    # multiply final horizontal position by final depth
    answer = new_pos.h * new_pos.d
    IO.puts("answer: #{answer}")
    answer
  end
  
  def run(filename, :stage2) do
    # initialize position map: {h: int, d: int}
    pos = initialize_position()
    # run input_text through translator
    moves = translate(filename)
    # apply positional changes
    new_pos = move_aim(pos, moves)
    # multiply final horizontal position by final depth
    answer = new_pos.h * new_pos.d
    IO.puts("answer (stage2): #{answer}")
    answer
  end
  
  # -- positional functions --
  def initialize_position do
    %{h: 0, d: 0, aim: 0}
  end
  
  def forward(%{h: horizontal, d: depth}, amount) do
    %{h: horizontal + amount, d: depth}
  end
  
  def down(%{h: horizontal, d: depth}, amount) do
    %{h: horizontal, d: depth + amount}
  end
  
  def up(%{h: horizontal, d: depth}, amount) do
    %{h: horizontal, d: depth - amount}
  end
  
  def aim_forward(%{h: horizontal, d: depth, aim: aim}, amount) do
    %{h: horizontal + amount, d: depth + (amount * aim), aim: aim}
  end
  
  def aim_down(%{h: horizontal, d: depth, aim: aim}, amount) do
    %{h: horizontal, d: depth, aim: aim + amount}
  end
  
  def aim_up(%{h: horizontal, d: depth, aim: aim}, amount) do
    %{h: horizontal, d: depth, aim: aim - amount}
  end
  
  def move(pos, []) do
    pos
  end
  def move(pos, [%{go: direction, amount: amount} | rest]) do
    case direction do
      "forward" ->  move(forward(pos, amount), rest)
      "down" ->     move(down(pos, amount), rest)
      "up" ->       move(up(pos, amount), rest)
    end
  end
  
  def move_aim(pos, []) do
    pos
  end
  def move_aim(pos, [%{go: direction, amount: amount} | rest]) do
    case direction do
      "forward" ->  move_aim(aim_forward(pos, amount), rest)
      "down" ->     move_aim(aim_down(pos, amount), rest)
      "up" ->       move_aim(aim_up(pos, amount), rest)
    end
  end
  
  def translate(filename) do
    # open file
    {:ok, input} = File.read(filename)
    
    # turn it into a list by /r/n
    String.split(input, ["\r", "\n", "\r\n"], trim: true)
    # returns list of maps: {go: "forward", amount: 5}
    |> Enum.map(fn x -> String.split(x, " ") end) 
    |> Enum.map(fn [dir, a] -> %{go: dir, amount: String.to_integer(a)} end) 
  end
end
