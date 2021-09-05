defmodule Livekanban.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias Livekanban.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "boards" do
    field :title, :string
    has_many :column, Livekanban.Column
    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

  def find_by!(id) do
    case Repo.get(__MODULE__, id) do
      nil -> {:error, :not_found}
      board -> {:ok, board |> Repo.preload(column: :card) }
    end
  end
end
