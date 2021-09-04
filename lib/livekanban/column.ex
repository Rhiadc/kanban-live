defmodule Livekanban.Column do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "columns" do
    field :title, :string
    belongs_to :board, Livekanban.Board
    has_many :card, Livekanban.Card
    timestamps()
  end

  @doc false
  def changeset(column, attrs) do
    column
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
