defmodule ForexFun.OrderCalcSpec do
  use ExUnit.Case

  import OrderCalc

  test "sets correct units by position" do
    assert get_units("Sell") == "-1000"
    assert get_units("Buy") == "1000"
  end

  test "returns new price for stop loss" do
    assert get_stop_loss("1.00", "Buy") == "0.99"
  end

  test "returns new price for take profit" do
    assert get_take_profit("1.00", "Buy") == "1.01"
  end
end
