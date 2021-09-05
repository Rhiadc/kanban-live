defmodule Livekanban.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string
      add :column_id, references(:columns, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:cards, [:column_id])
  end
end
