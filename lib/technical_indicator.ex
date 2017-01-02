defmodule TechnicalIndicator do

  def investing_indicators do
    Enum.map(investing_indicator_rows(), fn(x) ->
      row = elem(x, 2)

      %{currency: Floki.text(List.first(row)), 
        price: Floki.text(Enum.at(row, 1)),
        five_minutes: Floki.text(Enum.at(row, 2)),
        fifteen_minutes: Floki.text(Enum.at(row, 3)),
        one_hour: Floki.text(Enum.at(row, 4)) } 
    end)
  end

  def investing_indicator_rows do
    html = investing_raw_html()
    Enum.concat(Floki.find(html, "tr.ftqtr1"), Floki.find(html, "tr.ftqtr2"))
  end

  def investing_raw_html do
    HTTPoison.get!(investing_url()).body
  end

  def investing_url do
    'http://tools.investing.com/technical_summary.php?pairs=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18&fields=5m,15m,1h'
  end
end