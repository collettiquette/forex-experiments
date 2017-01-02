defmodule Oanda.CandleStickData do
  import StandardDeviation, only: [get_standard_deviation_and_mean: 1]

  @count 720
  @granularity %{:five_seconds => :S5, :five_seconds => :S5, :thirty_seconds => :S30, :one_minute => :M1, :five_minutes => :M5, :one_day => :D}

  def get_url(instrument) do
    "/v3/instruments/#{instrument}/candles/?" <> URI.encode_query(%{:count => @count, :granularity => @granularity.one_day})
  end

  def process_candle_sticks(%{:body => %{"candles" => list}}) do
    list
    |> Enum.map(fn(candle_stick) -> candle_stick["mid"]["c"] |> String.to_float end)
  end

  def get_price_list(instrument) do
    instrument
    |> get_url
    |> Oanda.get!
    |> process_candle_sticks
  end

  def get_standard_deviation_for_instrument(instrument) do
    instrument
    |> get_price_list
    |> get_standard_deviation_and_mean
  end
end
