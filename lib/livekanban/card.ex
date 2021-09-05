defmodule Livekanban.Card do
  use Ecto.Schema
  import Ecto.Changeset

  alias Livekanban.{Repo, Card}

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

  def update(id, changes) do
    with card when not is_nil(card) <- Repo.get(Card, id),
      {:ok, card} <- do_update(card, changes) do
        {:ok, card |> Repo.preload(column: :board)}
      else
        {:error, reason} -> {:error, reason}
      end
  end

  defp do_update(card, changes) do
    card
    |> changeset(changes)
    |> Repo.update()
  end
end
