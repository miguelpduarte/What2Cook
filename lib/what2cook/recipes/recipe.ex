defmodule What2cook.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :description, :string
    field :ingredients, :string
    field :source, :string
    field :title, :string
    field :type, Ecto.Enum, values: [:meat, :fish, :vegetarian, :vegan]

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :source, :type, :ingredients, :description])
    |> validate_required([:title, :source, :type, :ingredients, :description])
  end
end
