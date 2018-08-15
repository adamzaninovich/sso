defmodule Sso.Credentials.Credential do
  use Ecto.Schema
  import Ecto.Changeset


  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :sso_id, Ecto.UUID

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password_hash, :sso_id])
    |> validate_required([:email, :password_hash, :sso_id])
    |> unique_constraint(:sso_id)
  end
end
