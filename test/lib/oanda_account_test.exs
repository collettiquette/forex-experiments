defmodule ForexFun.OandaAccountSpec do
  use ExUnit.Case

  import Oanda.Account

  @eur_usd %{
    "asks" => [
      %{"liquidity" => 10000000,"price" => "1.05967"},
      %{"liquidity" => 10000000, "price" => "1.05969"}
    ],
    "bids" => [
      %{"liquidity" => 10000000, "price" => "1.05953"},
      %{"liquidity" => 10000000, "price" => "1.05951"}
    ],
    "closeoutAsk" => "1.05971",
    "closeoutBid" => "1.05949",
    "instrument" => "EUR_USD",
  }
  @usd_cad %{
    "asks" => [
      %{"liquidity" => 1000000, "price" => "1.35080"},
      %{"liquidity" => 2000000, "price" => "1.35081"},
      %{"liquidity" => 5000000, "price" => "1.35082"},
      %{"liquidity" => 10000000, "price" => "1.35084"}
    ],
    "bids" => [
      %{"liquidity" => 1000000, "price" => "1.35061"},
      %{"liquidity" => 2000000, "price" => "1.35060"},
      %{"liquidity" => 5000000, "price" => "1.35059"},
      %{"liquidity" => 10000000, "price" => "1.35057"}
    ],
    "closeoutAsk" => "1.35084", 
    "closeoutBid" => "1.35057",
    "instrument" => "USD_CAD",
  }

  test "filters out open instruments" do
    actions = [{"EUR_USD", :action}, {"NZD_USD", :action}]
    open_instruments = ["EUR_USD", "AUD_EUR"]
    assert filter_open_instruments(open_instruments, actions) == [{"NZD_USD", :action}]
  end

  test "finds min ask price for multiple instruments" do
    assert parse_ask_price(%{:body => %{"prices" => [@eur_usd, @usd_cad]}}, ["EUR_USD", "USD_CAD"]) == [{"1.05969", "EUR_USD"}, {"1.35084", "USD_CAD"}]
  end

  test "finds min ask price for single instrument" do
    assert parse_ask_price(%{:body => %{"prices" => [@eur_usd]}}, "EUR_USD") == "1.05969"
  end
end
