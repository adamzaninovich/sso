defmodule Sso.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :string
      add :password_hash, :string
      add :sso_id, :uuid

      timestamps()
    end

    create unique_index(:credentials, [:sso_id])
  end
end
