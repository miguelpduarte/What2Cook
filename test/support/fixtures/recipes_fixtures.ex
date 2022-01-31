defmodule What2cook.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `What2cook.Recipes` context.
  """

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(%{
        description: "some description",
        ingredients: "some ingredients",
        source: "some source",
        title: "some title",
        type: :meat
      })
      |> What2cook.Recipes.create_recipe()

    recipe
  end
end
