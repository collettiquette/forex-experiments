defmodule StandardDeviation do
  import OrderCalc, only: [get_pip_length: 1]

  def get_precision(list) do
    max(List.first(list) |> get_pip_length, List.last(list) |> get_pip_length)
  end

  def get_mean(list) do
    mean = list
    |> Enum.reduce(0, fn(value, sum) -> value + sum end)

    mean / length(list)
    |> Float.round(get_precision(list))
  end

  def get_mean_of_squares(list, mean) do
    squares_means = list
    |> Enum.reduce(0, fn(value, sum) -> :math.pow(value - mean, 2) + sum end)

    squares_means / (length(list) -1)
    |> :math.pow(0.5)
    |> Float.round(get_precision(list))
  end

  def get_standard_deviation_and_mean(list) do
    mean = get_mean(list)
    {mean, get_mean_of_squares(list, mean)}
  end
end