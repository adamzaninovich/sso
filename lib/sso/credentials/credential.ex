defmodule Sso.Credentials.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  schema "credentials" do
    field(:email, :string)
    field(:password_hash, :string)
    field(:sso_id, Ecto.UUID)

    field(:password, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> create_sso_id()
    |> validate_required([:sso_id])
    |> unique_constraint(:sso_id)
    |> hash_password()
    |> validate_required(:password_hash)
    |> unique_constraint(:email)
  end

  defp hash_password(%{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Bcrypt.add_hash(password))
  end

  defp hash_password(changeset), do: changeset

  defp create_sso_id(%{valid?: true, data: %{sso_id: nil}} = changeset) do
    put_change(changeset, :sso_id, Ecto.UUID.generate())
  end

  defp create_sso_id(changeset), do: changeset
end
