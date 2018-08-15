defmodule Sso.CredentialsTest do
  use Sso.DataCase

  alias Sso.Credentials

  describe "credentials" do
    alias Sso.Credentials.Credential

    @valid_attrs %{email: "some email", password_hash: "some password_hash", sso_id: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash", sso_id: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{email: nil, password_hash: nil, sso_id: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Credentials.create_credential()

      credential
    end

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()
      assert Credentials.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_fixture()
      assert Credentials.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Credentials.create_credential(@valid_attrs)
      assert credential.email == "some email"
      assert credential.password_hash == "some password_hash"
      assert credential.sso_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Credentials.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()
      assert {:ok, credential} = Credentials.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.email == "some updated email"
      assert credential.password_hash == "some updated password_hash"
      assert credential.sso_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Credentials.update_credential(credential, @invalid_attrs)
      assert credential == Credentials.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Credentials.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Credentials.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Credentials.change_credential(credential)
    end
  end
end
