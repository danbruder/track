defmodule Track.Time.Helpers do
  def parse_date(date) do
    Date.from_iso8601(date)
  end
end
