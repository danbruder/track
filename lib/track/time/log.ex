defmodule Track.Time.Log do
  use Ecto.Schema
  import Ecto.Changeset


  schema "logs" do
    field :bill_rate, :decimal
    field :billable, :boolean, default: false
    field :billed, :boolean, default: false
    field :date, :date
    field :description, :string
    field :hours, :decimal
    field :internal_cost, :decimal
    field :opportunity_cost, :decimal
    field :profit, :decimal

    belongs_to(:user, Track.Accounts.User)
    belongs_to(:project, Track.Time.Project)
    belongs_to(:client, Track.Time.Client)

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:description, :hours, :date, :billable, :bill_rate, :opportunity_cost, :internal_cost, :profit, :billed, :project_id, :client_id, :user_id])
    |> validate_required([:description, :hours, :date, :billable, :bill_rate, :opportunity_cost, :internal_cost, :profit, :billed, :project_id, :client_id, :user_id])
  end
end
