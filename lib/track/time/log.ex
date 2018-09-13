defmodule Track.Time.Log do
  use Ecto.Schema
  import Ecto.Changeset
  alias Track.Time

  schema "logs" do
    # Raw data
    field(:description, :string)
    field(:hours, :decimal)
    field(:date, :date)
    # field(:bill_rate, :decimal)
    # field(:internal_rate, :decimal)
    # field(:billable, :boolean, default: true)
    field(:billed, :boolean, default: false)

    # Computed fields
    # field(:revenue, :decimal)
    # field(:internal_cost, :decimal)
    # field(:opportunity_cost, :decimal)
    # field(:profit, :decimal)

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
      :billed,
      :project_id,
      :user_id
    ])
    |> cast_date(attrs)
    |> validate_required([
      :description,
      :hours,
      :date,
      :user_id,
      :project_id
    ])

    # |> inherit_bill_rates
    # |> put_calculated_fields
  end

  defp inherit_bill_rates(
         %Ecto.Changeset{
           valid?: true,
           changes: %{project_id: project_id}
         } = changeset
       ) do
    case Time.project_by_id(project_id) do
      {:ok, project} ->
        if project.override_rates do
          change(
            changeset,
            %{
              bill_rate: project.bill_rate,
              internal_rate: project.internal_rate,
              billable: project.billable
            }
          )
        else
          case Time.client_by_project_id(project_id) do
            {:ok, client} ->
              change(
                changeset,
                %{
                  bill_rate: client.bill_rate,
                  internal_rate: client.internal_rate,
                  billable: client.billable
                }
              )

            {:error, error} ->
              add_error(
                changeset,
                :project_id,
                "Could not find client for project. Please set bill rates on project or client"
              )
          end
        end

      {:error, error} ->
        add_error(changeset, :project_id, "Could not find project")
    end
  end

  defp inherit_bill_rates(changeset), do: changeset

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
