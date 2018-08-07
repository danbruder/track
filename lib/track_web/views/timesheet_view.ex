defmodule TrackWeb.TimesheetView do
  use TrackWeb, :view
  alias Track.Accounts
  alias Track.Time

  def all_users() do
    Accounts.list_users()
    |> Enum.map(fn u ->
      {u.first_name, u.id}
    end)
  end

  def all_projects() do
    Time.list_projects()
    |> Enum.map(fn p ->
      {p.name, p.id}
    end)
  end

  def user_logs_by_date() do
    Time.list_logs()
  end

  def format_date(date) do
    case date do
      %Date{day: day, month: month, year: year} ->
        "#{month}/#{day}/#{year}"

      date ->
        date
    end
  end
end
