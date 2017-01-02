defmodule Oanda.Account do
  
  @account_id Application.get_env(:forex_fun, :account_id)
  @accounts_url "/v3/accounts/#{@account_id}"
  @open_positions "/v3/accounts/#{@account_id}/openPositions"
  @pricing "/v3/accounts/#{@account_id}/pricing"

  def get_instrument_ask_price(instrument) do
    Oanda.get!(@pricing, [], params: %{instruments: instrument})
    |> parse_ask_price(instrument)
  end

  def parse_ask_price(resp, instrument) when is_bitstring instrument do
    parse_ask_price(resp, [instrument])
    |> Enum.map(fn({price, _inst}) -> price end)
    |> List.first
  end

  def parse_ask_price(%{body: price_resp}, instrument_list) do
    Map.fetch!(price_resp, "prices")
    |> Enum.map(fn instrument_price ->
        Map.fetch!(instrument_price, "asks")
        |> Enum.max_by(fn ask -> ask["price"] end) |> Map.fetch!("price")
      end)
    |> Enum.zip(instrument_list)
  end

  def filter_open_instruments(open_instruments, actions_list) do
    Enum.filter(actions_list, fn(action) -> !Enum.member?(open_instruments, elem(action, 0)) end)
  end

  def remove_open_instruments(action_list), do: get_open_position_instruments |> filter_open_instruments(action_list)

  def get_open_position_instruments do
    Oanda.get!(@open_positions).body
    |> Map.get("positions")
    |> Enum.map(&(Map.get(&1, "instrument")))
  end

  def get_account do
    Oanda.get(@accounts_url)
  end
end