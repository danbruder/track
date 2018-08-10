# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Track.Repo.insert!(%Track.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Track.{Time, Repo, Accounts}
alias Track.Time.{Project, Client}
alias Track.Accounts.User

User |> Repo.delete_all()
Project |> Repo.delete_all()
Client |> Repo.delete_all()

Accounts.register(%{
  "first_name" => "Dan",
  "last_name" => "Bruder",
  "email" => "dan@dan.com",
  "password" => "dandan"
})

{:ok, %{id: id}} = Time.create_client(%{name: "No client", billable: false})
Time.create_project(%{name: "No project", client_id: id})
