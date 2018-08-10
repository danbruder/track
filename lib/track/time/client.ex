defmodule Track.Time.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field(:name, :string)
    field(:bill_rate, :decimal)
    field(:internal_rate, :decimal)
    field(:billable, :boolean)
    has_many(:projects, Track.Time.Project)
    has_many(:logs, Track.Time.Log)

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:name, :billable, :internal_rate, :bill_rate])
    |> validate_required([:name, :billable])
    |> require_rates_if_billable
  end

  defp require_rates_if_billable(%Ecto.Changeset{changes: changes} = changeset) do
    case changes do
      %{billable: true} ->
        changeset
        |> validate_required([:internal_rate, :bill_rate])

      _ ->
        changeset
        |> change(%{internal_rate: Decimal.new(0)})
        |> change(%{bill_rate: Decimal.new(0)})
    end
  end

  defp require_rates_if_billable(changeset), do: changeset
end
