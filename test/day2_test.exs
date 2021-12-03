defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "initialize_position returns a position map with both positions at 0" do
    assert Day2.initialize_position().h == 0
    assert Day2.initialize_position().d == 0
  end
  
  test "forward 5 from 0,0" do
    pos = Day2.initialize_position()
    
    assert Day2.forward(pos, 5) == %{h: 5, d: 0}
  end
  
  test "down 5 from 0,0" do
    pos = Day2.initialize_position()
    
    assert Day2.down(pos, 5) == %{h: 0, d: 5}
  end
  
  test "up 5 from 0,0 (We're flying!)" do
    pos = Day2.initialize_position()
    
    assert Day2.up(pos, 5) == %{h: 0, d: -5}
  end
  
  test "multiple moves from list of move maps" do
    pos = Day2.initialize_position()
    moves = [
      %{go: "down", amount: 5},
      %{go: "forward", amount: 5},
      %{go: "up", amount: 1}
    ]
    
    assert Day2.move(pos, moves) == %{h: 5, d: 4}
  end
  
  test "read example data into list of move maps" do
    assert Day2.translate("lib/input/example_data.txt") == 
    [%{go: "forward", amount: 5}, 
    %{go: "down", amount: 5}, 
    %{go: "forward", amount: 8}, 
    %{go: "up", amount: 3}, 
    %{go: "down", amount: 8}, 
    %{go: "forward", amount: 2}]
  end
  
  test "run example data" do
    assert Day2.run("lib/input/example_data.txt", :stage1) == 150
  end
  
  test "run actual data stage1" do
    Day2.run("lib/input/data.txt", :stage1)
  end
  
  test "run actual data stage2" do
    Day2.run("lib/input/data.txt", :stage2)
  end
end
