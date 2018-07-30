defmodule Track.TimeTest do
  use Track.DataCase

  alias Track.Accounts.User
  alias Track.Accounts

  alias Track.Time

  def user_fixture(attrs \\ %{}) do
    num = Enum.random(0..1000000)
    {:ok, user} =
      attrs
      |> Enum.into(%{
        first_name: "some name",
        last_name: "last name",
        avatar_url: "https://google.com",
        email: "foo#{num}@foo.com",
        password: "123123"
      })
      |> Accounts.register()

    user
  end

  def client_fixture(attrs \\ %{}) do
    user = user_fixture()

    {:ok, client} =
      attrs
      |> Enum.into(%{name: "some name", user_id: user.id})
      |> Time.create_client()

    client
  end

  def project_fixture(attrs \\ %{}) do
    user = user_fixture()
    client = client_fixture()

    {:ok, project} =
      attrs
      |> Enum.into(%{
        bill_rate: "120.5",
        name: "some name",
        billable: false,
        user_id: user.id,
        client_id: client.id
      })
      |> Time.create_project()

    project
  end

  def log_fixture(attrs \\ %{}) do
    user = user_fixture()
    client = client_fixture(%{user_id: user.id})
    project = project_fixture(%{client_id: client.id, user_id: user.id})

    {:ok, log} =
      attrs
      |> Enum.into(%{
        bill_rate: "120.5",
        billable: true,
        billed: true,
        date: ~D[2010-04-17],
        description: "some description",
        hours: "120.5",
        internal_cost: "120.5",
        opportunity_cost: "120.5",
        profit: "120.5",
        client_id: client.id,
        project_id: project.id,
        user_id: user.id
      })
      |> Time.create_log()

    log
  end

  describe "clients" do
    alias Track.Time.Client

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Time.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Time.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      user = user_fixture()
      assert {:ok, %Client{} = client} = Time.create_client(Map.merge(@valid_attrs, %{user_id: user.id}))
      assert client.name == "some name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Time.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, client} = Time.update_client(client, @update_attrs)
      assert %Client{} = client
      assert client.name == "some updated name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Time.update_client(client, @invalid_attrs)
      assert client == Time.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Time.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Time.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Time.change_client(client)
    end
  end

  describe "projects" do
    alias Track.Time.Project

    @valid_attrs %{bill_rate: "120.5", name: "some name", billable: false }
    @update_attrs %{bill_rate: "456.7", name: "some updated name", billable: true}
    @invalid_attrs %{bill_rate: nil, name: nil, billable: nil, user_id: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Time.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Time.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      user = user_fixture()
      client = client_fixture(%{user_id: user.id})
      assert {:ok, %Project{} = project} = Time.create_project(Map.merge(@valid_attrs, %{user_id: user.id, client_id: client.id}))
      assert project.bill_rate == Decimal.new("120.5")
      assert project.name == "some name"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Time.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, project} = Time.update_project(project, @update_attrs)
      assert %Project{} = project
      assert project.bill_rate == Decimal.new("456.7")
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Time.update_project(project, @invalid_attrs)
      assert project == Time.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Time.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Time.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Time.change_project(project)
    end
  end

  describe "logs" do
    alias Track.Time.Log

    @valid_attrs %{
      bill_rate: "120.5",
      billable: true,
      billed: true,
      date: ~D[2010-04-17],
      description: "some description",
      hours: "120.5",
      internal_cost: "120.5",
      opportunity_cost: "120.5",
      profit: "120.5",
    }
    @update_attrs %{
      bill_rate: "456.7",
      billable: false,
      billed: false,
      date: ~D[2011-05-18],
      description: "some updated description",
      hours: "456.7",
      internal_cost: "456.7",
      opportunity_cost: "456.7",
      profit: "456.7",
    }
    @invalid_attrs %{
      bill_rate: nil,
      billable: nil,
      billed: nil,
      date: nil,
      description: nil,
      hours: nil,
      internal_cost: nil,
      opportunity_cost: nil,
      profit: nil,
      client_id: nil,
      project_id: nil,
      user_id: nil
    }

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert Time.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert Time.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      user = user_fixture()
      client = client_fixture(%{user_id: user.id})
      project = project_fixture(%{client_id: client.id, user_id: user.id})
      assert {:ok, %Log{} = log} = Time.create_log(Map.merge(@valid_attrs, %{user_id: user.id, client_id: client.id, project_id: project.id}))
      assert log.bill_rate == Decimal.new("120.5")
      assert log.billable == true
      assert log.billed == true
      assert log.date == ~D[2010-04-17]
      assert log.description == "some description"
      assert log.hours == Decimal.new("120.5")
      assert log.internal_cost == Decimal.new("120.5")
      assert log.opportunity_cost == Decimal.new("120.5")
      assert log.profit == Decimal.new("120.5")
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Time.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      assert {:ok, log} = Time.update_log(log, @update_attrs)
      assert %Log{} = log
      assert log.bill_rate == Decimal.new("456.7")
      assert log.billable == false
      assert log.billed == false
      assert log.date == ~D[2011-05-18]
      assert log.description == "some updated description"
      assert log.hours == Decimal.new("456.7")
      assert log.internal_cost == Decimal.new("456.7")
      assert log.opportunity_cost == Decimal.new("456.7")
      assert log.profit == Decimal.new("456.7")
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = Time.update_log(log, @invalid_attrs)
      assert log == Time.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = Time.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> Time.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = Time.change_log(log)
    end
  end
end
