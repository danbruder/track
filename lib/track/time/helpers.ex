defmodule Track.Time.Helpers do
  def parse_date(date) do
    Date.from_iso8601(date)
  end

  def dates_this_week_from_date(date) do
    first_date =
      date
      |> first_date_of_week_from_date

    0..6
    |> Enum.map(fn i ->
      Timex.shift(first_date, days: i)
    end)
  end

  def first_date_of_week_from_date(date) do
    today = Timex.weekday(date)
    Timex.shift(date, days: -today + 1)
  end

  def first_date_of_week_from_date_with_prev_and_next(date) do
    first_date =
      date
      |> first_date_of_week_from_date

    previous = Timex.shift(first_date, weeks: -1)
    next = Timex.shift(first_date, weeks: 1)

    %{
      previous: previous,
      current: first_date,
      next: next
    }
  end

  def date_to_human_format(date) do
    format(date, "{M}/{D}/{YY}")
  end

  def date_to_machine_format(date) do
    format(date, "{YYYY}-{0M}-{0D}")
  end

  def date_to_day_of_week(date) do
    format(date, "{WDfull}")
  end

  defp format(date, format) do
    date
    |> Timex.format(format)
    |> handle_date_format_error
  end

  defp handle_date_format_error(format_result) do
    case format_result do
      {:ok, result} ->
        result

      {:error, :invalid_format} ->
        "Invalid format"
    end
  end
end
