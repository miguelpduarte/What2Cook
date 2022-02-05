defmodule What2Cook.MenuGenerator do
  @moduledoc """
  The MenuGenerator context.
  """

  import Ecto.Query, warn: false
  alias What2Cook.Repo

  alias What2Cook.Recipes.Recipe
  alias What2Cook.MenuGenerator.MenuConfig

  def generate_menu(n_recipes) do
    n_total_recipes = Repo.aggregate(Recipe, :count, :id)

    case n_recipes > n_total_recipes do
      true ->
        {:error, "Not enough recipes to generate the requested menu"}

      # if n_recipes > n_total_recipes,
      #   do: raise("There are not enough recipes in the system to generate the requested menu")
      false ->
        # See https://stackoverflow.com/questions/53165642/fetch-random-records-from-ecto-database
        # There might be a faster solution to consider if the table grows substantially
        {:ok,
         Recipe
         |> select([:id, :title, :type, :ingredients])
         |> order_by(fragment("RANDOM()"))
         |> limit(^n_recipes)
         |> Repo.all()}
    end
  end

  def get_default_config() do
    %MenuConfig{number: 1}
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking menu config changes.

  ## Examples

      iex> change_recipe(config)
      %Ecto.Changeset{data: %MenuConfig{}}

  """
  def change(%MenuConfig{} = menu_config, attrs \\ %{}) do
    MenuConfig.changeset(menu_config, attrs)
  end
end
