defmodule ForexFun.StatsSpec do
  use ExUnit.Case

  import StandardDeviation

  test "gets mean" do
    assert get_mean([0.0, 20.0, 30.0, 50.0]) == 25.0
  end

  test "get standard deviation" do
    assert get_standard_deviation_and_mean([0.0, 20.0, 30.0, 50.0]) == {25.0, Float.round(20.82, 1)}
  end
end
