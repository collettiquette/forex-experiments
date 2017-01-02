defmodule Reliefweb do
  use HTTPoison.Base

  @key "brGet7wyBK-kx1FKw73M"

  def process_url(url) do
    IO.puts("http://api.sigimera.org/v1#{url}?auth_token=#{@key}")
    "https://api.sigimera.org/v1#{url}?auth_token=#{@key}"
  end

  defp key do
    "brGet7wyBK-kx1FKw73M"
  end
end

