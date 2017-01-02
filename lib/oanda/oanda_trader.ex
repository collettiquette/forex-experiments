defmodule Oanda.Trader do

  import OrderCalc

  @account_id Application.get_env(:forex_fun, :account_id)
  @order_url "/v3/accounts/#{@account_id}/orders"

  def set_price(order, instrument) do
    %Oanda.BuyOrder{ order | price: Oanda.Account.get_instrument_ask_price(instrument) }
  end

  def set_units(order, position) do
    %Oanda.BuyOrder{ order | units: OrderCalc.get_units(position) }
  end

  def set_stop_loss(order, position, sigma) do
    %Oanda.BuyOrder{ order | stopLossOnFill: %Oanda.ProfitLossOrder{price: get_stop_loss(order.price, position, sigma) } }
  end

  def set_take_profit(order, position, sigma) do
    %Oanda.BuyOrder{ order | takeProfitOnFill: %Oanda.ProfitLossOrder{price: get_take_profit(order.price, position, sigma) } }
  end

  def build_order(instrument, position) do
    sigma = Oanda.CandleStickData.get_standard_deviation_for_instrument(instrument)
    order = %Oanda.BuyOrder{instrument: instrument}
    |> set_price(instrument)
    |> set_units(position)
    |> set_stop_loss(position, sigma)
    |> set_take_profit(position, sigma)
    %{order: order}
  end

  def make_order({instrument, position, _price}) do
    order = build_order(instrument, position)
    Oanda.post(@order_url, order)
  end
end