defmodule Track.AccountsTest do
  use Track.DataCase

  alias Track.Accounts

  describe "users" do
    alias Track.Accounts.User

    @valid_attrs %{
      avatar_url: "some avatar_url",
      email: "some@email.com",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "some password"
    }
    @update_attrs %{
      avatar_url: "some updated avatar_url",
      email: "updated@email.com",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      password: "some updated password"
    }
    @invalid_attrs %{avatar_url: nil, email: nil, first_name: nil, last_name: nil, password: nil}

    test "Accounts.register/1 allows registration of new account" do
      {:ok, user} = Track.Accounts.register(@valid_attrs)
    end
  end
end
