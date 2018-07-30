defmodule Track.TimeTest do
  use Track.DataCase

  alias Track.Time

  describe "clients" do
    alias Track.Time.Client

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Time.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Time.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Time.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Time.create_client(@valid_attrs)
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

    @valid_attrs %{bill_rate: "120.5", name: "some name"}
    @update_attrs %{bill_rate: "456.7", name: "some updated name"}
    @invalid_attrs %{bill_rate: nil, name: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Time.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Time.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Time.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Time.create_project(@valid_attrs)
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
end
