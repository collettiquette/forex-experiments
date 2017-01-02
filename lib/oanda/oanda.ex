defmodule Oanda do
  use HTTPoison.Base

  @key "028e6aba2a91993bd457a496fc06cf1c-14ac39509f51c2bfaaf182658da5b99a"
  def process_url(url) do
    "https://api-fxpractice.oanda.com" <> url
  end

  def process_request_headers(headers) do 
    Enum.concat(headers, [{"Authorization", "Bearer #{@key}"}, {"Content-Type", "application/json"}])
  end
  
  def process_response_body(body) do
    body
    |> Poison.decode!
  end

  def process_request_body(body) do
    body
    |> Poison.encode!
  end

  defp key do
    "028e6aba2a91993bd457a496fc06cf1c-14ac39509f51c2bfaaf182658da5b99a"

  end
  # NOTE: Following functions are overwritable for HTTPoison
  # defp process_request_body(body), do: body
  # defp process_response_body(body), do: body
  # defp process_request_headers(headers) when is_map(headers) do
  #   Enum.into(headers, [])
  # end
  # defp process_request_headers(headers), do: headers
  # defp process_response_chunk(chunk), do: chunk
  # defp process_headers(headers), do: headers
  # defp process_status_code(status_code), do: status_code
  # defp process_url(url), do: url
end
