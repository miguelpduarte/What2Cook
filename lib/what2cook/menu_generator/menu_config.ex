defmodule What2Cook.MenuGenerator.MenuConfig do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :number, :integer
  end

  @doc false
  def changeset(config, attrs) do
    config
    |> cast(attrs, [:number])
    |> validate_required([:number])
    # TODO: Adjust the upper bound according to use
    |> validate_number(:number, greater_than_or_equal_to: 1, less_than: 20)
  end
end
