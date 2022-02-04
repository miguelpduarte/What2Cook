defmodule What2CookWeb.MenuGeneratorLive.Index do
  use What2CookWeb, :live_view
  require Logger

  alias What2Cook.MenuGenerator

  @impl true
  def mount(_params, _session, socket) do
    default_config = MenuGenerator.get_default_config()
    changeset = MenuGenerator.change(default_config)

    {:ok,
     socket
     # Start without recipes fetched
     |> assign(:recipes, nil)
     |> assign(:changeset, changeset)
     |> assign(:menu_config, default_config)}
  end

  @impl true
  def handle_event("generate", %{"menu_config" => menu_config_params}, socket) do
    # Update changeset and check if it is valid
    changeset =
      socket.assigns.menu_config
      |> MenuGenerator.change(menu_config_params)
      |> Map.put(:action, :validate)

    # If so, get the menu thingies
    recipes =
      if changeset.valid? do
        changeset
        |> Ecto.Changeset.get_field(:number)
        |> MenuGenerator.generate_menu()
      end

    socket = assign(socket, :recipes, recipes)
    # ^The above logic should probably be in the context (?) lol

    # Update the changeset anyway
    socket = assign(socket, :changeset, changeset)

    {:noreply, socket}
  end

  # # TODO: Implement getting a generated menu here
  # @impl true
  # def handle_params(params, _url, socket) do
  #   {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  # end

  # defp list_recipes do
  #   Recipes.list_recipes()
  # end
end
