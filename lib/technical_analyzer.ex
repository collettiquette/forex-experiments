defmodule TechnicalAnalyzer do
  def make_actions(action_currency) do
    {String.replace(action_currency[:currency], "/", "_"), String.replace(action_currency[:five_minutes], "Strong ", ""), String.to_float(action_currency[:price])}
  end

  def actionable_currencies do
    Enum.filter(TechnicalIndicator.investing_indicators(), fn(currency_row) -> actionable?(currency_row) end)
  end

  def actionable? currency_row do
    ((currency_row[:five_minutes] == currency_row[:fifteen_minutes]) && (currency_row[:five_minutes] == currency_row[:one_hour])) && 
      (currency_row[:five_minutes] == "Strong Buy" || currency_row[:five_minutes] == "Strong Sell")
  end

  def get_the_deals do
    Oanda.start
    actionable_currencies
    |> Enum.map(&make_actions/1)
    |> Oanda.Account.remove_open_instruments
    |> Enum.map(&Oanda.Trader.make_order/1)
  end
end
  