defmodule Mix.Tasks.Oanda.MakeDeals do
  use Mix.Task

  def run(_) do
    TechnicalAnalyzer.get_the_deals
  end
end
