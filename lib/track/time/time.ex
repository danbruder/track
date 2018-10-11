defmodule Track.Time do
  @moduledoc """
  The Time context.
  """

  import Ecto.Query, warn: false
  alias Track.Repo

  alias Track.Time.Project
  alias Track.Time.Client

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients do
    Client
    |> preload(:projects)
    |> Repo.all()
  end

  @doc """
  Gets a single client.

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client!(123)
      %Client{}

      iex> get_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client!(id), do: Repo.get!(Client, id)

  @doc """
  Gets a single client with projects

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client_with_projects!(123)
      %Client{}

      iex> get_client_with_projects!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client_with_projects!(id),
    do:
      Client
      |> preload(:projects)
      |> Repo.get!(id)

  @doc """
  Creates a client.

  ## Examples

      iex> create_client(%{field: value})
      {:ok, %Client{}}

      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a client.

  ## Examples

      iex> update_client(client, %{field: new_value})
      {:ok, %Client{}}

      iex> update_client(client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_client(%Client{} = client, attrs) do
    client
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Client.

  ## Examples

      iex> delete_client(client)
      {:ok, %Client{}}

      iex> delete_client(client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_client(%Client{} = client) do
    Repo.delete(client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking client changes.

  ## Examples

      iex> change_client(client)
      %Ecto.Changeset{source: %Client{}}

  """
  def change_client(%Client{} = client \\ %Client{}) do
    Client.changeset(client, %{})
  end

  def clients_exist?() do
    from(p in Client, select: count(p.id))
    |> Repo.one()
    |> case do
      i when i > 0 ->
        true

      _ ->
        false
    end
  end

  def client_by_id(id) do
    Client
    |> Repo.get_by(id: id)
    |> case do
      nil ->
        {:error, :not_found}

      client ->
        {:ok, client}
    end
  end

  def client_by_project_id(id) do
    from(p in Project, where: p.id == ^id, select: p.client_id)
    |> Repo.one()
    |> case do
      id when is_number(id) ->
        client_by_id(id)

      nil ->
        {:error, :not_found}
    end
  end

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Project
    |> preload(:client)
    |> Repo.all()
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{source: %Project{}}

  """
  def change_project(%Project{} = project \\ %Project{}) do
    Project.changeset(project, %{})
  end

  def projects_exist?() do
    from(p in Project, select: count(p.id))
    |> Repo.one()
    |> case do
      i when i > 0 ->
        true

      _ ->
        false
    end
  end

  def project_by_id(id) do
    Project
    |> Repo.get_by(id: id)
    |> case do
      nil ->
        {:error, :not_found}

      project ->
        {:ok, project}
    end
  end

  alias Track.Time.Log

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%Log{}, ...]

  """
  def list_logs do
    Log
    |> preload(:project)
    |> Repo.all()
  end

  def list_logs_for_user_and_date(user, date) do
    from(
      l in Log,
      where: l.user_id == ^user.id and l.date == ^date
    )
    |> preload(:project)
    |> Repo.all()
  end

  @doc """
  Gets a single log.

  Raises `Ecto.NoResultsError` if the Log does not exist.

  ## Examples

      iex> get_log!(123)
      %Log{}

      iex> get_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log!(id), do: Repo.get!(Log, id)
  def get_log(id), do: Repo.get(Log, id)

  def get_log_with_project(id),
    do: from(l in Log, where: l.id == ^id, preload: [:project]) |> Repo.one()

  @doc """
  Creates a log.

  ## Examples

      iex> create_log(%{field: value})
      {:ok, %Log{}}

      iex> create_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log(attrs \\ %{}) do
    %Log{}
    |> Log.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a log.

  ## Examples

      iex> update_log(log, %{field: new_value})
      {:ok, %Log{}}

      iex> update_log(log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_log(%Log{} = log, attrs) do
    log
    |> Log.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Log.

  ## Examples

      iex> delete_log(log)
      {:ok, %Log{}}

      iex> delete_log(log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log(%Log{} = log) do
    Repo.delete(log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log changes.

  ## Examples

      iex> change_log(log)
      %Ecto.Changeset{source: %Log{}}

  """
  def change_log(%Log{} = log \\ %Log{}) do
    Log.changeset(log, %{})
  end
end
