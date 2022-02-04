defmodule What2Cook.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :title, :string
      add :source, :string
      add :type, :string
      add :ingredients, :string
      add :description, :string

      timestamps()
    end
  end
end
