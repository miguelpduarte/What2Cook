defmodule What2Cook.RecipesTest do
  use What2Cook.DataCase

  alias What2Cook.Recipes

  describe "recipes" do
    alias What2Cook.Recipes.Recipe

    import What2Cook.RecipesFixtures

    @invalid_attrs %{description: nil, ingredients: nil, source: nil, title: nil, type: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      valid_attrs = %{
        description: "some description",
        ingredients: "some ingredients",
        source: "some source",
        title: "some title",
        type: :meat
      }

      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(valid_attrs)
      assert recipe.description == "some description"
      assert recipe.ingredients == "some ingredients"
      assert recipe.source == "some source"
      assert recipe.title == "some title"
      assert recipe.type == :meat
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()

      update_attrs = %{
        description: "some updated description",
        ingredients: "some updated ingredients",
        source: "some updated source",
        title: "some updated title",
        type: :fish
      }

      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, update_attrs)
      assert recipe.description == "some updated description"
      assert recipe.ingredients == "some updated ingredients"
      assert recipe.source == "some updated source"
      assert recipe.title == "some updated title"
      assert recipe.type == :fish
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe == Recipes.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end
end
