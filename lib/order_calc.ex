defmodule OrderCalc do
  @stop_loss_dev 1.0
  @take_profit_dev 2.0

  def get_pip_length(price) when is_float(price), do: price |> to_string |> get_pip_length
  def get_pip_length price do
    price
      |> String.split(".")   
      |> List.last
      |> String.length
  end

  def get_units("Buy"), do: "-1000"
  def get_units("Sell"), do: "1000"

  def get_price_precision price do
    price
    |> String.length
  end

  def get_stop_loss(price, "Buy", sigma), do: get_margin(price, sigma, @stop_loss_dev)
  def get_stop_loss(price, "Sell", sigma), do: get_margin(price, sigma, -@stop_loss_dev)
  def get_take_profit(price, "Buy", sigma), do: get_margin(price, sigma, -@take_profit_dev)
  def get_take_profit(price, "Sell", sigma), do: get_margin(price, sigma, @take_profit_dev)

  def get_margin(price, {_mean, deviation}, rate) do
    (price |> String.to_float) + (rate * deviation)
    |> Float.round(get_price_precision(price))
    |> Float.to_string
  end
end