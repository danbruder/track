defmodule Track.Time.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    # Raw data

    field(:bill_rate, :decimal)
    field(:billable, :boolean, default: false)
    field(:billed, :boolean, default: false)
    field(:date, :date)
    field(:description, :string)
    field(:hours, :decimal)
    field(:internal_rate, :decimal)

    # Computed fields
    field(:revenue, :decimal)
    field(:internal_cost, :decimal)
    field(:opportunity_cost, :decimal)
    field(:profit, :decimal)

    belongs_to(:user, Track.Accounts.User)
    belongs_to(:project, Track.Time.Project)
    belongs_to(:client, Track.Time.Client)

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [
      :description,
      :hours,
      :billable,
      :bill_rate,
      :internal_rate,
      :billed,
      :project_id,
      :client_id,
      :user_id
    ])
    |> cast_date(attrs)
    |> validate_required([
      :description,
      :hours,
      :date,
      :billable,
      :bill_rate,
      :internal_rate,
      :billed,
      :project_id,
      :user_id
    ])
    |> put_calculated_fields
  end

  defp put_calculated_fields(
         %Ecto.Changeset{
           valid?: true,
           changes: changes
         } = changeset
       ) do
    bill_rate = Decimal.new(changes.bill_rate)
    internal_rate = Decimal.new(changes.internal_rate)
    hours = Decimal.new(changes.hours)

    revenue = Decimal.mult(bill_rate, hours)
    internal_cost = Decimal.mult(internal_rate, hours)
    profit = Decimal.sub(revenue, internal_cost)

    change(changeset, %{
      revenue: revenue,
      internal_cost: internal_cost,
      opportunity_cost: Decimal.new(0),
      profit: profit
    })
  end

  defp put_calculated_fields(changeset), do: changeset

  defp cast_date(changeset, args) do
    with %{"date" => date} <- args,
         {:ok, date} <- Date.from_iso8601(date) do
      changeset
      |> put_change(:date, date)
    else
      {:error, :invalid_format} ->
        add_error(changeset, :date, "Invalid date format")

      _ ->
        changeset
    end
  end
end
