defmodule ForexFun.Oanda.TraderSpec do
  use ExUnit.Case

  import Oanda.Trader

  test "builds an order struct" do
    instrument = "EUR_USD"
    position = "Sell"
    order_struct = build_order(instrument, position).order
    
    assert order_struct.instrument == "EUR_USD"
    assert is_bitstring order_struct.units
    assert is_bitstring order_struct.price

    assert String.to_float(order_struct.price) < String.to_float(order_struct.takeProfitOnFill.price)
    assert String.to_float(order_struct.price) > String.to_float(order_struct.stopLossOnFill.price)
  end
end
