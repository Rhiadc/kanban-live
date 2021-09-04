defmodule Livekanban.Card do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :content, :string
    belongs_to :column, Livekanban.Column
    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
