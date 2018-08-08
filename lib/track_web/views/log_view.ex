defmodule TrackWeb.LogView do
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
end
