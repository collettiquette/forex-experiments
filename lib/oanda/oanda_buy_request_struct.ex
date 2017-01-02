defmodule Oanda.BuyOrder do
  defstruct instrument: nil, units: nil, timeInForce: :GTC, type: :LIMIT, positionFill: :DEFAULT, takeProfitOnFill: nil, stopLossOnFill: nil, price: nil
end