defmodule What2CookWeb.RecipeLive.Index do
  use What2CookWeb, :live_view

  alias What2Cook.Recipes
  alias What2Cook.Recipes.Recipe

  @impl true
  def mount(_params, _session, socket) do
    recipes = list_recipes()

    # :total_recipes is used to filter always on the same original list, instead of successively filtering the same list
    {:ok, assign(socket, recipes: recipes, total_recipes: recipes)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Recipe")
    |> assign(:recipe, Recipes.get_recipe!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Recipe")
    |> assign(:recipe, %Recipe{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Recipes")
    |> assign(:recipe, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    recipe = Recipes.get_recipe!(id)
    {:ok, _} = Recipes.delete_recipe(recipe)

    recipes = list_recipes()
    {:noreply, assign(socket, recipes: recipes, total_recipes: recipes)}
  end

  def handle_event("search", %{"search" => %{"query" => search_query}}, socket) do
    filtered_recipes =
      if String.trim(search_query) != "" do
        search_query = String.downcase(search_query)

        socket.assigns.total_recipes
        |> Enum.filter(&String.contains?(String.downcase(&1.title), search_query))
      else
        socket.assigns.total_recipes
      end

    {:noreply,
     socket
     |> assign(:recipes, filtered_recipes)}
  end

  defp list_recipes do
    Recipes.list_recipes()
  end
end
