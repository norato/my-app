defmodule MyApp.Repo.Migrations.AddPasswordHashToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :email, :string, null: false
      add :password_hash, :string
    end
  end
end
